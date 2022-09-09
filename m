Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC95B391A
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 15:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiIINgR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 09:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiIINgQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 09:36:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6172E129C6B
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Sep 2022 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662730574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r+j5NRBRWTe4dwiHyAiQIy4Dst2HaG54q1byj2vgh9A=;
        b=cRagtOr7fsMrTdHyBAlsC9Zd3n0yeBcLIfkYYHUSTzgQckqFNOnXUavFvOn4FBgRCpk6f6
        QmcfG5Yf1BEsXRlO+mcEqR3We/68lfn+oa9exTVgB591Bul9b01x74dTb5BrkT+1sX4xII
        5gzGXzDa5FuTieWIQ9N1o4saneV3c6A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-yEfQCMORNCSmTpexHCrisQ-1; Fri, 09 Sep 2022 09:36:12 -0400
X-MC-Unique: yEfQCMORNCSmTpexHCrisQ-1
Received: by mail-pg1-f197.google.com with SMTP id j3-20020a634a43000000b00429f2cb4a43so1008390pgl.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Sep 2022 06:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=r+j5NRBRWTe4dwiHyAiQIy4Dst2HaG54q1byj2vgh9A=;
        b=UVQXbkDfo0s39I1rdEa3x/Fy+DWyHp4RdTG/KzgiwT9B8rxEMbzHXJvh6F8qIvcAVA
         SPfMzeAzT4GxqwBC9tHlwfPggW/fAKe2zB1UxTuNWA4IRNwI03Y9J+VaWXgk+T1HGh7I
         fbTXJ0n64G1+Tr2H8XUWKne0SZhetJq91yMInPdJiGuyUQksdQUBJSeQukHTERwhr7dd
         rjbVaBB3liWOs10Qhf1QlwQ2D7AlVVuwJZ0MeugCZ0kMGgtZqiHoR+++zkUhiNtr2CcK
         fOV4CRajd9ftUVvHoXQr+kVL4dn3OcAALkXy8IUy03gh/3T8EvEAKCtOdNjH2PYQ2S1C
         NuNA==
X-Gm-Message-State: ACgBeo1qhy+m4LqGuqS7hzoPHi78dNcAwS08Lz69fV9kRLWBEVjNa9oV
        B2MrcCPnS/wamQfnOW8j9hZJLZshhWZnnZKgB3uGSllsutz+xJzWh71IN6N4iVbMHhtKQn4ecv2
        hcr7QmUp6g1K5Y0zb4SmEGbdIXLfD7ivEWnKvetp35WmB
X-Received: by 2002:a63:f74c:0:b0:42b:77c2:ce7c with SMTP id f12-20020a63f74c000000b0042b77c2ce7cmr12592095pgk.473.1662730571983;
        Fri, 09 Sep 2022 06:36:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5SuJp+5hF11ORlTCZwHRZ31liJYmxmCrru4MNb9MY8mX5OINDPGCydElCCxBRT4j/66jaTrmZy9iz49jm7DGI=
X-Received: by 2002:a63:f74c:0:b0:42b:77c2:ce7c with SMTP id
 f12-20020a63f74c000000b0042b77c2ce7cmr12592074pgk.473.1662730571756; Fri, 09
 Sep 2022 06:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yxn5VDzJMUxSKz0Z@fedora> <23a76ce3-d568-3c73-eecc-fa499aeecfcd@linux.intel.com>
In-Reply-To: <23a76ce3-d568-3c73-eecc-fa499aeecfcd@linux.intel.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Fri, 9 Sep 2022 10:36:00 -0300
Message-ID: <CAAq0SUk9_DS4T5_uAg+3re7=wrGXMkiXgw_oPsWfrmgY79P=2g@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] selftests: tdx: Test TDX attestation GetReport support
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 8, 2022 at 8:45 PM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 9/8/22 7:16 AM, Wander Lairson Costa wrote:
> >> +#ifdef DEBUG
> >> +static void print_array_hex(const char *title, const char *prefix_str,
> >> +            const void *buf, int len)
> >> +{
> >> +    const __u8 *ptr = buf;
> >> +    int i, rowsize = HEX_DUMP_SIZE;
> >> +
> >> +    if (!len || !buf)
> >> +            return;
> >> +
> >> +    printf("\t\t%s", title);
> >> +
> >> +    for (i = 0; i < len; i++) {
> >> +            if (!(i % rowsize))
> >> +                    printf("\n%s%.8x:", prefix_str, i);
> >> +            printf(" %.2x", ptr[i]);
> >> +    }
> >> +
> >> +    printf("\n");
> >> +}
> >> +#endif
> >> +
> >> +TEST(verify_report)
> >> +{
> >> +    __u8 reportdata[TDX_REPORTDATA_LEN];
> >> +    struct tdreport tdreport;
> >> +    struct tdx_report_req req;
> >> +    int devfd, i;
> >> +
> >> +    devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
> >> +
> >> +    ASSERT_LT(0, devfd);
> >> +
> >> +    /* Generate sample report data */
> >> +    for (i = 0; i < TDX_REPORTDATA_LEN; i++)
> >> +            reportdata[i] = i;
> >> +
> >> +    /* Initialize IOCTL request */
> >> +    req.subtype     = 0;
> >> +    req.reportdata  = (__u64)reportdata;
> >> +    req.rpd_len     = TDX_REPORTDATA_LEN;
> >> +    req.tdreport    = (__u64)&tdreport;
> >> +    req.tdr_len     = sizeof(tdreport);
> >> +
> >> +    /* Get TDREPORT */
> >> +    ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT, &req));
> >> +
> >> +#ifdef DEBUG
> >> +    print_array_hex("\n\t\tTDX report data\n", "",
> >> +                    reportdata, sizeof(reportdata));
> >> +
> >> +    print_array_hex("\n\t\tTDX tdreport data\n", "",
> >> +                    &tdreport, sizeof(tdreport));
> >> +#endif
> > You can unconditionally define print_array_hex, and
> > use `if (DEBUG)` instead of #ifdef `DEBUG here`. The compiler
> > will get rid of the unused code when DEBUG is not defined
> > as expected, but you get the parser to validate it
> > independent of the definition of DEBUG.
>
> Currently, DEBUG is a macro, so we cannot use if (DEBUG) directly.
> You are suggesting to change DEBUG to a variable? Any reason to
> make this change? I think both changes are functionally similar.
> So I am wondering why to make this change?
>

My thought is always to define DEBUG. If in debug mode it is defined
to 1; otherwise to 0.
Then, you can use `if (DEBUG)` instead of `#ifdef DEBUG`. But the
former will always check the syntax of the debug code,
independent of the value of DEBUG, and the compiler will generate the
same code. The GNU coding standard [1] explains that
better than I do.

[1] https://www.gnu.org/prep/standards/standards.html#Conditional-Compilation

> >
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>

