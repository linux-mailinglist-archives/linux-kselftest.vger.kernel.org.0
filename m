Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16613180D22
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 02:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgCKBJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Mar 2020 21:09:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:12990 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgCKBJY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Mar 2020 21:09:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 18:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="242515528"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2020 18:09:22 -0700
Message-ID: <7a1f93d4516a7de99c5dbc4afd6279d6fe7aa126.camel@intel.com>
Subject: Re: [PATCH V1 09/13] selftests/resctrl: Modularize fill_buf for new
 CAT test case
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, babu.moger@amd.com, james.morse@arm.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Mar 2020 18:04:34 -0700
In-Reply-To: <4c84be1d-8839-2c85-b294-7e3c454240bb@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
         <43b368952bb006ee973311d9c9ae0eb53d8e7f60.1583657204.git.sai.praneeth.prakhya@intel.com>
         <4c84be1d-8839-2c85-b294-7e3c454240bb@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Reinette,

On Tue, 2020-03-10 at 14:59 -0700, Reinette Chatre wrote:
> Hi Sai,
> 
> On 3/6/2020 7:40 PM, Sai Praneeth Prakhya wrote:
> > Currently fill_buf (in-built benchmark) runs as a separate process and it
> > runs indefinitely looping around given buffer either reading it or writing
> > to it. But, some future test cases might want to start and stop looping
> > around the buffer as they see fit. So, modularize fill_buf to support this
> > use case.
> > 
> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > ---
> >  tools/testing/selftests/resctrl/fill_buf.c | 66 ++++++++++++++++++++-----
> > -----
> >  1 file changed, 44 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/resctrl/fill_buf.c
> > b/tools/testing/selftests/resctrl/fill_buf.c
> > index 9ede7b63f059..204ae8870a32 100644
> > --- a/tools/testing/selftests/resctrl/fill_buf.c
> > +++ b/tools/testing/selftests/resctrl/fill_buf.c
> > @@ -23,7 +23,7 @@
> >  #define PAGE_SIZE		(4 * 1024)
> >  #define MB			(1024 * 1024)
> >  
> > -static unsigned char *startptr;
> > +static unsigned char *startptr, *endptr;

[Snipped.. assuming code over here might not be needed for discussion]

> > +static int use_buffer_forever(int op, char *resctrl_val)
> > +{
> > +	int ret;
> > +
> >  	if (op == 0)
> > -		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
> > +		ret = fill_cache_read(resctrl_val);
> >  	else
> > -		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
> > +		ret = fill_cache_write(resctrl_val);
> >  
> >  	if (ret) {
> >  		printf("\n Errror in fill cache read/write...\n");
> >  		return -1;
> >  	}
> >  
> > +	return 0;
> > +}
> > +
> > +static int
> > +fill_cache(unsigned long long buf_size, int malloc_and_init, int
> > memflush,
> > +	   int op, char *resctrl_val)
> > +{
> > +	int ret;
> > +
> > +	ret = init_buffer(buf_size, malloc_and_init, memflush);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = use_buffer_forever(op, resctrl_val);
> > +	if (ret)
> > +		return ret;
> 
> Should buffer be freed on this error path?

Yes, that's right.. my bad. Will fix it. But the right fix is,
use_buffer_forever() should not return at all. It's meant to loop around the
buffer _forever_.

> I think the asymmetrical nature of the memory allocation and release
> creates traps like this.
> 
> It may be less error prone to have the pointer returned by init_buffer
> and the acted on and released within fill_cache(), passed to
> "use_buffer_forever()" as a parameter.  The buffer size is known here,
> there is no need to keep an "end pointer" around.

The main reason for having "startptr" as a global variable is to free memory
when fill_buf is killed. fill_buf runs as a separate process (for test cases
like MBM, MBA and CQM) and when user issues Ctrl_c or when the test kills
benchmark_pid (i.e. fill_buf), the buffer is freed (please see
ctrl_handler()).

So, I thought, as "startptr" is anyways global, why pass it around as an
argument? While making this change I thought it's natural to make "endptr"
global as well because the function didn't really look good to just take
endptr as an argument without startptr.

I do agree that asymmetrical nature of the memory allocation and release might
create traps, I will try to overcome this for CAT test case (other test cases
will not need it).

Regards,
Sai

