Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B53467B87C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 18:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjAYR1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 12:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjAYR1U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 12:27:20 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348E30E9;
        Wed, 25 Jan 2023 09:27:18 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30PHOh0f3191260
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 25 Jan 2023 09:24:43 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30PHOh0f3191260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1674667484;
        bh=E6ZzjSvSbOY36CL4Ti5rEQx63MkTAMDPF+DyyM4GwZs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=dxTDz57hBamdDcZbJiBjHk5SCcxYmmC7kpsvv/b/0vkYBstNrKJpJA3MmZhEDaDgo
         +qP2uCpDjkKh3ExV/Q7SdTmsGhmDvzhUV4JEQbxLT3EkZZ00iNFTy/dXAeyWPkO/YL
         ax85Silr+iqPkWqJD14N06T9qv3BkUUpQTrbhT/4jr13HNlIB1rWh7iJrN2xEzgjGs
         3WWP0+QTsUYNwjniu1eRAF636DHVomElYfMzWJxmq3LaEOtvT7WC4LulLbzzWoAQn2
         usAGv5mrlp21A7URRoO+k7hLqWQztYTDbkbSzVPHg1OWHsgeODhKBptRJYWvrgncpK
         DDNIotQd3xbUw==
Date:   Wed, 25 Jan 2023 09:24:40 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Li, Xin3" <xin3.li@intel.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?RE=3A_=5BRFC_PATCH_v5_0/2=5D_sysret=5Frip_up?= =?US-ASCII?Q?date_for_the_Intel_FRED_architecture?=
User-Agent: K-9 Mail for Android
In-Reply-To: <SA1PR11MB673480C4129F7A7EA9DFAF4AA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <6cd0db14-c9e2-3598-fd10-4b473d78c373@citrix.com> <5ecc383c-621b-57d9-7f6d-d63496fca3b3@zytor.com> <20230124022729.596997-1-ammarfaizi2@gnuweeb.org> <20230124022729.596997-3-ammarfaizi2@gnuweeb.org> <ce25e53f-91d4-d793-42a5-036d6bce0b4c@zytor.com> <Y899kHYbz32H1S6a@biznet-home.integral.gnuweeb.org> <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org> <20230125034958.734527-1-ammarfaizi2@gnuweeb.org> <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com> <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org> <SA1PR11MB673480C4129F7A7EA9DFAF4AA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <A5C220D5-BCE6-42DC-8115-ED41CD011993@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On January 25, 2023 9:07:18 AM PST, "Li, Xin3" <xin3=2Eli@intel=2Ecom> wrot=
e:
>> > This version passes on FRED, thanks a lot for quickly fixing it=2E
>>=20
>> Great!
>>=20
>> Can you pick these two patches and include it in the next version of
>> "x86: enable FRED for x86-64" RFC patchset?
>
>Would it be better to get this patch set merged first?
>
>Otherwise surely I will include it in the FRED patch set=2E
>
>  Xin
>
>=20
>

If the maintainers are ok with it, it would be better to merge it sooner: =
once we have agreed on the semantics, which I believe we have, we should be=
 testing those semantics and nothing else=2E
