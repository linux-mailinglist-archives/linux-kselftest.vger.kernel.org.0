Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE52D5F7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Dec 2020 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbgLJPVl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Dec 2020 10:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391471AbgLJPQx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Dec 2020 10:16:53 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB2C06179C
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 07:16:13 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2so4367478pfq.5
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ZRkSD0Q57BhwAifo2zbWB1GnhkM5sfgv11URhPoKJvI=;
        b=mJpQkx5DuKXjnzxJcDiFhvesmPZulAjLaZyoKF9b0TcBKkJgtMyY/yd7datmdIkf3l
         wDyFPxdbU35gEQ/pEX3CVf0PLNHD2eMPUPFUYVRrn2aAiKBG5b1796tkaXQKWgVCZQd1
         z84Pu6rbNn4kNAHICiftdvfPJkzsSHaGXacG4NCquX3Ys8X6xyUWE4ctOnyatv4lgTHE
         P3W9mn4Zt634Fc/7D7abawqoJUNQxwdOQytnRqpFde6s6OVXX+KsoV5PKgKsYtrGNSlv
         Vyv3O31DitJvejfpNLjH9qZa+FHgkXxeWPSv/APTrmBHzF3pB+tfnFqqlb2N8UsTN97b
         yWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ZRkSD0Q57BhwAifo2zbWB1GnhkM5sfgv11URhPoKJvI=;
        b=GA7kOEKYkD9x6Qb16DyT07gT5I3KJoVjBPLXqqb4e7RkYC6c+9AngcziyX5v9S91wa
         FIVHMOn6XkEbFsUQMyZpHRqLTJqMBLclZzW1uNyjwWm+wPOrnXnj/BYAWHV8X1a5rkdI
         8TIYnPkTqKwqk+b/wsb4rAQ++OXjDKPpB0nSFSOYPDKJID3HXXvxyNvTwlIG2TcnOnTe
         E3TQu1ogaUwKNos7hleZUnxDAIu7yKcU5pdKIr7a4yzBX4gu3VMr2eFG0unB7SVN09/H
         Fx8ibpmTh2cGKE4GhZtQ9ciy1nae53ivkS73iZcmTyw2IhNCICbPnaKhZkblJC4OFNC/
         qxUQ==
X-Gm-Message-State: AOAM532CKNA0PPF2J669RtW/bo0cDeQC+JcDTnPtPj/96huafphEi4Pt
        6jnfMNx4VfoNb1fGSpfmFRs1nQ==
X-Google-Smtp-Source: ABdhPJx46Ci6hjCq0tAYhUM/2n8+GZTDgJP0pxIYwMM2jhoQAngZlbEdM/F8U+CzdFsazwI5ydqLyA==
X-Received: by 2002:a17:90a:e38c:: with SMTP id b12mr8266014pjz.177.1607613372534;
        Thu, 10 Dec 2020 07:16:12 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:b5ad:66ae:88c:b76d? ([2601:646:c200:1ef2:b5ad:66ae:88c:b76d])
        by smtp.gmail.com with ESMTPSA id 19sm7079080pfu.85.2020.12.10.07.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 07:16:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/3] KVM: x86: implement KVM_{GET|SET}_TSC_STATE
Date:   Thu, 10 Dec 2020 07:16:10 -0800
Message-Id: <E4F263BE-6CAA-4152-8818-187D34D8D0FD@amacapital.net>
References: <9389c1198da174bcc9483d6ebf535405aa8bdb45.camel@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
In-Reply-To: <9389c1198da174bcc9483d6ebf535405aa8bdb45.camel@redhat.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Dec 10, 2020, at 6:52 AM, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>=20
> =EF=BB=BFOn Thu, 2020-12-10 at 12:48 +0100, Paolo Bonzini wrote:
>>> On 08/12/20 22:20, Thomas Gleixner wrote:
>>> So now life migration comes a long time after timekeeping had set the
>>> limits and just because it's virt it expects that everything works and i=
t
>>> just can ignore these limits.
>>>=20
>>> TBH. That's not any different than SMM or hard/firmware taking the
>>> machine out for lunch. It's exactly the same: It's broken.
>>=20
>> I agree.  If *live* migration stops the VM for 200 seconds, it's broken.
>>=20
>> Sure, there's the case of snapshotting the VM over the weekend.  My=20
>> favorite solution would be to just put it in S3 before doing that.  *Do=20=

>> what bare metal does* and you can't go that wrong.
>=20
> Note though that qemu has a couple of issues with s3, and it is disabled=20=

> by default in libvirt.=20
> I would be very happy to work on improving this if there is a need for tha=
t.

There=E2=80=99s also the case where someone has a VM running on a laptop and=
 someone closes the lid. The host QEMU might not have a chance to convince t=
he guest to enter S3.

>=20
>=20
>>=20
>> In general it's userspace policy whether to keep the TSC value the same=20=

>> across live migration.  There's pros and cons to both approaches, so KVM=20=

>> should provide the functionality to keep the TSC running (which the=20
>> guest will see as a very long, but not extreme SMI), and this is what=20
>> this series does.  Maxim will change it to operate per-VM.  Thanks=20
>> Thomas, Oliver and everyone else for the input.
>=20
> I agree with that.
>=20
> I still think though that we should have a discussion on feasibility
> of making the kernel time code deal with large *forward* tsc jumps=20
> without crashing.
>=20
> If that is indeed hard to do, or will cause performance issues,
> then I agree that we might indeed inform the guest of time jumps instead.
>=20

Tglx, even without fancy shared host/guest timekeeping, count the guest kern=
el manage to update its timekeeping if the host sent the guest an interrupt o=
r NMI on all CPUs synchronously on resume?

Alternatively, if we had the explicit =E2=80=9Cmax TSC value that makes sens=
e right now=E2=80=9D in the timekeeping data, the guest would reliably notic=
e the large jump and could at least do something intelligent about it instea=
d of overflowing its internal calculation.=
