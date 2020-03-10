Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F90180B03
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Mar 2020 22:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgCJV7m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 17:59:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:22711 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJV7m (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 17:59:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 14:59:41 -0700
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="242466540"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.10.135]) ([10.251.10.135])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Mar 2020 14:59:40 -0700
Subject: Re: [PATCH V1 09/13] selftests/resctrl: Modularize fill_buf for new
 CAT test case
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
 <43b368952bb006ee973311d9c9ae0eb53d8e7f60.1583657204.git.sai.praneeth.prakhya@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <4c84be1d-8839-2c85-b294-7e3c454240bb@intel.com>
Date:   Tue, 10 Mar 2020 14:59:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <43b368952bb006ee973311d9c9ae0eb53d8e7f60.1583657204.git.sai.praneeth.prakhya@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sai,

On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> Currently fill_buf (in-built benchmark) runs as a separate process and it
> runs indefinitely looping around given buffer either reading it or writing
> to it. But, some future test cases might want to start and stop looping
> around the buffer as they see fit. So, modularize fill_buf to support this
> use case.
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> ---
>  tools/testing/selftests/resctrl/fill_buf.c | 66 ++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
> index 9ede7b63f059..204ae8870a32 100644
> --- a/tools/testing/selftests/resctrl/fill_buf.c
> +++ b/tools/testing/selftests/resctrl/fill_buf.c
> @@ -23,7 +23,7 @@
>  #define PAGE_SIZE		(4 * 1024)
>  #define MB			(1024 * 1024)
>  
> -static unsigned char *startptr;
> +static unsigned char *startptr, *endptr;
>  
>  static void sb(void)
>  {
> @@ -82,13 +82,13 @@ static void *malloc_and_init_memory(size_t s)
>  	return p;
>  }
>  
> -static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
> +static int fill_one_span_read(void)
>  {
>  	unsigned char sum, *p;
>  
>  	sum = 0;
> -	p = start_ptr;
> -	while (p < end_ptr) {
> +	p = startptr;
> +	while (p < endptr) {
>  		sum += *p;
>  		p += (CL_SIZE / 2);
>  	}
> @@ -96,26 +96,24 @@ static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
>  	return sum;
>  }
>  
> -static
> -void fill_one_span_write(unsigned char *start_ptr, unsigned char *end_ptr)
> +static void fill_one_span_write(void)
>  {
>  	unsigned char *p;
>  
> -	p = start_ptr;
> -	while (p < end_ptr) {
> +	p = startptr;
> +	while (p < endptr) {
>  		*p = '1';
>  		p += (CL_SIZE / 2);
>  	}
>  }
>  
> -static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
> -			   char *resctrl_val)
> +static int fill_cache_read(char *resctrl_val)
>  {
>  	int ret = 0;
>  	FILE *fp;
>  
>  	while (1) {
> -		ret = fill_one_span_read(start_ptr, end_ptr);
> +		ret = fill_one_span_read();
>  		if (!strcmp(resctrl_val, "cat"))
>  			break;
>  	}
> @@ -130,11 +128,10 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
>  	return 0;
>  }
>  
> -static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
> -			    char *resctrl_val)
> +static int fill_cache_write(char *resctrl_val)
>  {
>  	while (1) {
> -		fill_one_span_write(start_ptr, end_ptr);
> +		fill_one_span_write();
>  		if (!strcmp(resctrl_val, "cat"))
>  			break;
>  	}
> @@ -142,24 +139,25 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
>  	return 0;
>  }
>  
> -static int
> -fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
> -	   int op, char *resctrl_val)
> +static
> +int init_buffer(unsigned long long buf_size, int malloc_and_init, int memflush)
>  {
>  	unsigned char *start_ptr, *end_ptr;
>  	unsigned long long i;
> -	int ret;
>  
>  	if (malloc_and_init)
>  		start_ptr = malloc_and_init_memory(buf_size);
>  	else
>  		start_ptr = malloc(buf_size);
>  
> -	if (!start_ptr)
> +	if (!start_ptr) {
> +		printf("Failed to allocate memory to buffer\n");
>  		return -1;
> +	}
>  
> -	startptr = start_ptr;
>  	end_ptr = start_ptr + buf_size;
> +	endptr = end_ptr;
> +	startptr = start_ptr;
>  
>  	/*
>  	 * It's better to touch the memory once to avoid any compiler
> @@ -176,16 +174,40 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
>  	if (memflush)
>  		mem_flush(start_ptr, buf_size);
>  
> +	return 0;
> +}
> +
> +static int use_buffer_forever(int op, char *resctrl_val)
> +{
> +	int ret;
> +
>  	if (op == 0)
> -		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
> +		ret = fill_cache_read(resctrl_val);
>  	else
> -		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
> +		ret = fill_cache_write(resctrl_val);
>  
>  	if (ret) {
>  		printf("\n Errror in fill cache read/write...\n");
>  		return -1;
>  	}
>  
> +	return 0;
> +}
> +
> +static int
> +fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
> +	   int op, char *resctrl_val)
> +{
> +	int ret;
> +
> +	ret = init_buffer(buf_size, malloc_and_init, memflush);
> +	if (ret)
> +		return ret;
> +
> +	ret = use_buffer_forever(op, resctrl_val);
> +	if (ret)
> +		return ret;

Should buffer be freed on this error path?

I think the asymmetrical nature of the memory allocation and release
creates traps like this.

It may be less error prone to have the pointer returned by init_buffer
and the acted on and released within fill_cache(), passed to
"use_buffer_forever()" as a parameter.  The buffer size is known here,
there is no need to keep an "end pointer" around.

> +
>  	free(startptr);
>  
>  	return 0;
> 

Reinette
