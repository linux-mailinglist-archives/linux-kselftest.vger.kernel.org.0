Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587773595D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Apr 2021 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhDIGwV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Apr 2021 02:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhDIGwU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Apr 2021 02:52:20 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1928C061760
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 23:52:07 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id h20so2278915plr.4
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 23:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=zShxkn+uNVnh/91t00SP5Bio+UEtA6GTrxuEKv1jxbk=;
        b=kRnzaFxi5L4Rn7dHB4YR+OVzWBUWgLhFSvxXqQojNCOuYshXJDV6Z569FnL6HPVfVE
         /bdnm3lt4LoOofmmMInMtSBG/j4s6+DDw1oBoCvcgV5IsjYL01FgBRPpzIuv+5CabY/S
         Y5wiygY8Exn1QlWlqvii1sVD6fOccGf8K2Kd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zShxkn+uNVnh/91t00SP5Bio+UEtA6GTrxuEKv1jxbk=;
        b=p7I8uMD3S5jimkRuIBcAnJmh09/1Bz3j8TXeMb8tGkdZYjBWzqR42MBhitx1YBs8g/
         gZsWdADFVqXdWXAzATXa+Cx7gyvIviflBwswKpOXu19zki07+zY7j+6605GARvLSzbfc
         VT51+UUosBxfwGU/fkbkOSKf5427WOtmYOYHlg3j8Y0l8mJ9JI3P1yug/xst32nkp4l0
         kLCQZ4vXtxA2etR3wphJz7bKWGbNpLSqgSFJWS3RfmZNy8XTjrbjb/yyl+9RWP1zMMCA
         P/NT0xuyliwClflb3HAYBbvQq9IN8gCQ09SPmGNeUPaJvMQHZ0pRKnra9NF/MBfWLxYo
         jEQg==
X-Gm-Message-State: AOAM531iDCRz+XlsHXQfrVotS1iAoz+2sv3i+jKyU0/fplWxVZxq693e
        LdbXhZAZFWPZjDrECeldH5ByFjlvlMPlbw==
X-Google-Smtp-Source: ABdhPJxypOuI/H4hCujZXTt3Xja+fVkWI+mVOwpCXpTbk9HLHIeDxUbHDiZWkuoO60vlurEKil8yxQ==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr12538750pjb.127.1617951127580;
        Thu, 08 Apr 2021 23:52:07 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-600a-73c5-13c4-f875.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:600a:73c5:13c4:f875])
        by smtp.gmail.com with ESMTPSA id v123sm1252401pfb.80.2021.04.08.23.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 23:52:07 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, shuah@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] powerpc/selftests/ptrace-hwbreak: Add testcases for 2nd DAWR
In-Reply-To: <20210407054938.312857-2-ravi.bangoria@linux.ibm.com>
References: <20210407054938.312857-1-ravi.bangoria@linux.ibm.com> <20210407054938.312857-2-ravi.bangoria@linux.ibm.com>
Date:   Fri, 09 Apr 2021 16:52:04 +1000
Message-ID: <87mtu8eyqz.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ravi,

> Add selftests to test multiple active DAWRs with ptrace interface.

It would be good if somewhere (maybe in the cover letter) you explain
what DAWR stands for and where to find more information about it. I
found the Power ISA v3.1 Book 3 Chapter 9 very helpful.

Apart from that, I don't have any specific comments about this patch. It
looks good to me, it seems to do what it says, and there are no comments
from checkpatch. It is a bit sparse in terms of comments but it is
consistent with the rest of the file so I can't really complain there :)

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

> Sample o/p:
>   $ ./ptrace-hwbreak
>   ...
>   PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED, WO, len: 6: Ok
>   PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED, RO, len: 6: Ok
>   PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, WO, len: 6: Ok
>   PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, RO, len: 6: Ok
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
> index 2e0d86e0687e..a0635a3819aa 100644
> --- a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
> +++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
> @@ -194,6 +194,18 @@ static void test_workload(void)
>  		big_var[rand() % DAWR_MAX_LEN] = 'a';
>  	else
>  		cvar = big_var[rand() % DAWR_MAX_LEN];
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED, WO test */
> +	gstruct.a[rand() % A_LEN] = 'a';
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED, RO test */
> +	cvar = gstruct.b[rand() % B_LEN];
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, WO test */
> +	gstruct.a[rand() % A_LEN] = 'a';
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, RO test */
> +	cvar = gstruct.a[rand() % A_LEN];
>  }
>  
>  static void check_success(pid_t child_pid, const char *name, const char *type,
> @@ -417,6 +429,69 @@ static void test_sethwdebug_range_aligned(pid_t child_pid)
>  	ptrace_delhwdebug(child_pid, wh);
>  }
>  
> +static void test_multi_sethwdebug_range(pid_t child_pid)
> +{
> +	struct ppc_hw_breakpoint info1, info2;
> +	unsigned long wp_addr1, wp_addr2;
> +	char *name1 = "PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED";
> +	char *name2 = "PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED";
> +	int len1, len2;
> +	int wh1, wh2;
> +
> +	wp_addr1 = (unsigned long)&gstruct.a;
> +	wp_addr2 = (unsigned long)&gstruct.b;
> +	len1 = A_LEN;
> +	len2 = B_LEN;
> +	get_ppc_hw_breakpoint(&info1, PPC_BREAKPOINT_TRIGGER_WRITE, wp_addr1, len1);
> +	get_ppc_hw_breakpoint(&info2, PPC_BREAKPOINT_TRIGGER_READ, wp_addr2, len2);
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW ALIGNED, WO test */
> +	wh1 = ptrace_sethwdebug(child_pid, &info1);
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DW UNALIGNED, RO test */
> +	wh2 = ptrace_sethwdebug(child_pid, &info2);
> +
> +	ptrace(PTRACE_CONT, child_pid, NULL, 0);
> +	check_success(child_pid, name1, "WO", wp_addr1, len1);
> +
> +	ptrace(PTRACE_CONT, child_pid, NULL, 0);
> +	check_success(child_pid, name2, "RO", wp_addr2, len2);
> +
> +	ptrace_delhwdebug(child_pid, wh1);
> +	ptrace_delhwdebug(child_pid, wh2);
> +}
> +
> +static void test_multi_sethwdebug_range_dawr_overlap(pid_t child_pid)
> +{
> +	struct ppc_hw_breakpoint info1, info2;
> +	unsigned long wp_addr1, wp_addr2;
> +	char *name = "PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap";
> +	int len1, len2;
> +	int wh1, wh2;
> +
> +	wp_addr1 = (unsigned long)&gstruct.a;
> +	wp_addr2 = (unsigned long)&gstruct.a;
> +	len1 = A_LEN;
> +	len2 = A_LEN;
> +	get_ppc_hw_breakpoint(&info1, PPC_BREAKPOINT_TRIGGER_WRITE, wp_addr1, len1);
> +	get_ppc_hw_breakpoint(&info2, PPC_BREAKPOINT_TRIGGER_READ, wp_addr2, len2);
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, WO test */
> +	wh1 = ptrace_sethwdebug(child_pid, &info1);
> +
> +	/* PPC_PTRACE_SETHWDEBUG 2, MODE_RANGE, DAWR Overlap, RO test */
> +	wh2 = ptrace_sethwdebug(child_pid, &info2);
> +
> +	ptrace(PTRACE_CONT, child_pid, NULL, 0);
> +	check_success(child_pid, name, "WO", wp_addr1, len1);
> +
> +	ptrace(PTRACE_CONT, child_pid, NULL, 0);
> +	check_success(child_pid, name, "RO", wp_addr2, len2);
> +
> +	ptrace_delhwdebug(child_pid, wh1);
> +	ptrace_delhwdebug(child_pid, wh2);
> +}
> +
>  static void test_sethwdebug_range_unaligned(pid_t child_pid)
>  {
>  	struct ppc_hw_breakpoint info;
> @@ -504,6 +579,10 @@ run_tests(pid_t child_pid, struct ppc_debug_info *dbginfo, bool dawr)
>  			test_sethwdebug_range_unaligned(child_pid);
>  			test_sethwdebug_range_unaligned_dar(child_pid);
>  			test_sethwdebug_dawr_max_range(child_pid);
> +			if (dbginfo->num_data_bps > 1) {
> +				test_multi_sethwdebug_range(child_pid);
> +				test_multi_sethwdebug_range_dawr_overlap(child_pid);
> +			}
>  		}
>  	}
>  }
> -- 
> 2.27.0
