Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360742601E3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Sep 2020 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgIGROK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Sep 2020 13:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgIGOQb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Sep 2020 10:16:31 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA057C061574
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Sep 2020 07:15:55 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so1648729pfn.9
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Sep 2020 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=pMKtnu62KrFlClqQRGBjCSOknfMgdgn3+wr6HnRppNY=;
        b=D64xvzFLBlnNeTQkT8TNQY9QSEEmAeebO85yfOC8NPD1qtRe6ZhnRviUtvOdxf7zNs
         K5w9Tc56LdukXCGiVOV0RnjgFVbBUOBeD0YvkNdcyIRUZqHMAGLUalClCgCTARRRghvX
         0syIVDRXlYXf/9UkCbwkjho2LiGFWDgF0jefQzrfll1AaP8/1iF03O7LOXwtlHzPC5o2
         I7l8npCZsBDhjEaTB0HUB7llatpo1fnrqibiAczZYpjt9RwxiE1/4IJ0nbgeUY7dfu0K
         DdpHrv1SwsxdcqShg+ockpxLo9zrZWTK4NGRi2HGlIb9t7VQbc2feZTADbtP9rlW2EI0
         cR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=pMKtnu62KrFlClqQRGBjCSOknfMgdgn3+wr6HnRppNY=;
        b=M5zyN3Exyl8fzagFDG6Yqlp/p3Epi8BA4fG1dGu5v0huwXRGoqn1SHfYZoBOUjb6B2
         cnHdrXPpdS89ZYzIvka2DaS8e6ervI2KE38poTgRZoWPKdYZY5K5EMFwqjbqEsMwg9C+
         0I7YKE8yNj8o5KC6D0KoUspbWxtcs0dDluG+z4evqaW7GFTjuIoV4kleImOX65x3lZaY
         RMA8nGsAgaO4EV4ta+6ujE28bEjPMNQ3MeUxU+OI9h3CEOtRbTNLZrg+TCfEZYu4YCip
         x2jWMbX5AKEni0o0pOYj1oZsviNz/tZwIpvDc1kH7ZtsgViR69kLerrgqEipbfvf4KGK
         Lk5Q==
X-Gm-Message-State: AOAM533sK8CqQ9aX5ymtu8s1cqAzcV/BIgxWOF25QYukdzAgoqZUE/H0
        En5G8cL3HAzJP2sTMO507qB9NQ==
X-Google-Smtp-Source: ABdhPJxDzNPgTKU+KaHZmsuByNel5l69rVNLnkpVmRixOH4K76E96CSThsbS7P+Xe0BpNllo+5a76Q==
X-Received: by 2002:a63:4a19:: with SMTP id x25mr16395793pga.56.1599488154774;
        Mon, 07 Sep 2020 07:15:54 -0700 (PDT)
Received: from ?IPv6:2600:1010:b025:3136:b1da:8d24:b138:6fff? ([2600:1010:b025:3136:b1da:8d24:b138:6fff])
        by smtp.gmail.com with ESMTPSA id m25sm15245324pfa.32.2020.09.07.07.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 07:15:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 6/9] kernel: entry: Support Syscall User Dispatch for common syscall entry
Date:   Mon, 7 Sep 2020 07:15:52 -0700
Message-Id: <0639209E-B6C6-4F86-84F4-04B91E1CC8AA@amacapital.net>
References: <20200907101522.zo6qzgp4qfzkz7cs@wittgenstein>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, luto@kernel.org,
        tglx@linutronix.de, keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
In-Reply-To: <20200907101522.zo6qzgp4qfzkz7cs@wittgenstein>
To:     Christian Brauner <christian.brauner@ubuntu.com>
X-Mailer: iPhone Mail (17H35)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On Sep 7, 2020, at 3:15 AM, Christian Brauner <christian.brauner@ubuntu.co=
m> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 04, 2020 at 04:31:44PM -0400, Gabriel Krisman Bertazi=
 wrote:
>> Syscall User Dispatch (SUD) must take precedence over seccomp, since the
>> use case is emulation (it can be invoked with a different ABI) such that
>> seccomp filtering by syscall number doesn't make sense in the first
>> place.  In addition, either the syscall is dispatched back to userspace,
>> in which case there is no resource for seccomp to protect, or the
>=20
> Tbh, I'm torn here. I'm not a super clever attacker but it feels to me
> that this is still at least a clever way to circumvent a seccomp
> sandbox.
> If I'd be confined by a seccomp profile that would cause me to be
> SIGKILLed when I try do open() I could prctl() myself to do user
> dispatch to prevent that from happening, no?
>=20

Not really, I think. The idea is that you didn=E2=80=99t actually do open().=
 You did a SYSCALL instruction which meant something else, and the syscall d=
ispatch correctly prevented the kernel from misinterpreting it as open().

