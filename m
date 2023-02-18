Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5469B817
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Feb 2023 05:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjBREyA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Feb 2023 23:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBREx7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Feb 2023 23:53:59 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B18C37552;
        Fri, 17 Feb 2023 20:53:58 -0800 (PST)
Received: from [127.0.0.1] ([73.223.221.228])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 31I4p62D4097556
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 17 Feb 2023 20:51:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 31I4p62D4097556
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023020601; t=1676695867;
        bh=ZsTHAJ2M1Xz9JWuAr5Ye7uhY5qSpwDVmBE6pAy6Pnuk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=pSF0bVgQSOMYifL3Yscavmko2uodmIldbVyi+FjaGVFUtkZmJoPM5m8kmf4kGcrKE
         0BH3WDlaqOROUPWYZQQ5pT0usvxFq0FiAJvmThmQl8+Wg/iUiQxfeQGxl0N/BMKbnA
         Be5cmEnrH1EKgGVHexICr8I+1zUnTYXKC/PsVVoG4toZbBIbs+PMSL+ywSqdSi6rjJ
         MNNadqgNa/HWpaDO7mbfEL39gs5WcwaileKqp0gssngfjJZIbTvzQ/5jflY79yEXld
         gHNVbU0qrLlmv5meHXuueCPhIG1OONBW8PJkjgbuTjKppA729SwWj9z+1rObRb7CYf
         2i2Hy1+df2FeA==
Date:   Fri, 17 Feb 2023 20:51:03 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Xin Li <xin3.li@intel.com>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        x86 Mailing List <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_v5_0/2=5D_sysret=5Frip_up?= =?US-ASCII?Q?date_for_the_Intel_FRED_architecture?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y/BTvGJT1QEz15w7@biznet-home.integral.gnuweeb.org>
References: <BC632CA8-D2CB-4781-82E5-9810347293B0@zytor.com> <Y8+hGxVpgFVcm15g@biznet-home.integral.gnuweeb.org> <20230125034958.734527-1-ammarfaizi2@gnuweeb.org> <SA1PR11MB67345C4DFEE720C08D30D93DA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com> <Y9DpNG+jb8G/lhA1@biznet-home.integral.gnuweeb.org> <SA1PR11MB673480C4129F7A7EA9DFAF4AA8CE9@SA1PR11MB6734.namprd11.prod.outlook.com> <A5C220D5-BCE6-42DC-8115-ED41CD011993@zytor.com> <Y9FpxEz2+LJc7vJP@biznet-home.integral.gnuweeb.org> <SA1PR11MB673454F82DEBD8A1C7009C79A8CE9@SA1PR11MB6734.namprd11.prod.outlook.com> <SA1PR11MB67342D0472C023619BDEFB26A8A39@SA1PR11MB6734.namprd11.prod.outlook.com> <Y/BTvGJT1QEz15w7@biznet-home.integral.gnuweeb.org>
Message-ID: <18C482AB-D01D-4AAC-BBA2-7A0F7D26ADA8@zytor.com>
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

On February 17, 2023 8:27:40 PM PST, Ammar Faizi <ammarfaizi2@gnuweeb=2Eorg=
> wrote:
>On Wed, Feb 15, 2023 at 07:42:47AM +0000, Li, Xin3 wrote:
>> Hi Faizi,
>>=20
>> Any update on this patch set?
>
>No comment from HPA=2E But after the recent discussion with Andrew, I
>think at least it's now clear that we are not going to use "+r"(rsp) to
>avoid the red zone problem=2E
>
>I am on leave today=2E Will send revision v8 on Monday=2E
>
>Thanks,
>

My apologies, I missed your latest response in the torrent of email=2E The=
 redzone issue is weird; it ought to be breaking all over the place, not ju=
st this=2E

Let me take a quick look at it=2E=2E=2E
