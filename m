Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F9F338BB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Mar 2021 12:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbhCLLl7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Mar 2021 06:41:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231734AbhCLLla (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Mar 2021 06:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615549289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8jHxvC75w9X24DxN9G8Wywf246TTfX1Ko6CkI1Ni8H8=;
        b=V6JESI1ONRiqrByEn9jkfKwCxMtcz/fvhXCB95NMVFxVcO0U9Yc4wJJRRWEIzcAuFpwaWQ
        78/QNz2tDpiYY/zDhDKp/J5TxzWYHw3XSJVgIhN+hUW9OBKGh1+1XMMytY+gEhshgyx79T
        IdqpGccn8ThKaAGKRy1KGhCK75h5+jA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-93NYT4tYNUKlYYYmJOtiQA-1; Fri, 12 Mar 2021 06:41:26 -0500
X-MC-Unique: 93NYT4tYNUKlYYYmJOtiQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C74C48AA1F6;
        Fri, 12 Mar 2021 11:41:12 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2D766F80B;
        Fri, 12 Mar 2021 11:40:32 +0000 (UTC)
Date:   Fri, 12 Mar 2021 12:40:29 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        yuzenghui@huawei.com
Subject: Re: [RFC PATCH v4 6/9] KVM: selftests: Add a helper to get system
 default hugetlb page size
Message-ID: <20210312114029.ju66lm5rrqdakgar@kamzik.brq.redhat.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
 <20210302125751.19080-7-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302125751.19080-7-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 02, 2021 at 08:57:48PM +0800, Yanan Wang wrote:
> If HUGETLB is configured in the host kernel, then we can know the system
> default hugetlb page size through *cat /proc/meminfo*. Otherwise, we will
> not see the information of hugetlb pages in file /proc/meminfo if it's not
> configured. So add a helper to determine whether HUGETLB is configured and
> then get the default page size by reading /proc/meminfo.
> 
> This helper can be useful when a program wants to use the default hugetlb
> pages of the system and doesn't know the default page size.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> ---
>  .../testing/selftests/kvm/include/test_util.h |  1 +
>  tools/testing/selftests/kvm/lib/test_util.c   | 27 +++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
> index ef24c76ba89a..e087174eefe5 100644
> --- a/tools/testing/selftests/kvm/include/test_util.h
> +++ b/tools/testing/selftests/kvm/include/test_util.h
> @@ -80,6 +80,7 @@ struct vm_mem_backing_src_alias {
>  
>  bool thp_configured(void);
>  size_t get_trans_hugepagesz(void);
> +size_t get_def_hugetlb_pagesz(void);
>  void backing_src_help(void);
>  enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
>  
> diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
> index f2d133f76c67..80d68dbd72d2 100644
> --- a/tools/testing/selftests/kvm/lib/test_util.c
> +++ b/tools/testing/selftests/kvm/lib/test_util.c
> @@ -153,6 +153,33 @@ size_t get_trans_hugepagesz(void)
>  	return size;
>  }
>  
> +size_t get_def_hugetlb_pagesz(void)
> +{
> +	char buf[64];
> +	const char *tag = "Hugepagesize:";
> +	FILE *f;
> +
> +	f = fopen("/proc/meminfo", "r");
> +	TEST_ASSERT(f != NULL, "Error in opening /proc/meminfo: %d", errno);
> +
> +	while (fgets(buf, sizeof(buf), f) != NULL) {
> +		if (strstr(buf, tag) == buf) {
> +			fclose(f);
> +			return strtoull(buf + strlen(tag), NULL, 10) << 10;
> +		}
> +	}
> +
> +	if (feof(f)) {
> +		fclose(f);
> +		TEST_FAIL("HUGETLB is not configured in host kernel");
> +	} else {
> +		fclose(f);
> +		TEST_FAIL("Error in reading /proc/meminfo: %d", errno);
> +	}

fclose() can be factored out.

> +
> +	return 0;
> +}
> +
>  void backing_src_help(void)
>  {
>  	int i;
> -- 
> 2.23.0
>

Besides the fclose comment and the same errno comment as the previous
patch

Reviewed-by: Andrew Jones <drjones@redhat.com>

