Return-Path: <linux-kselftest+bounces-5154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BE85D518
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 11:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25FC1C23D39
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B03D996;
	Wed, 21 Feb 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVHjyzqL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB143D96B;
	Wed, 21 Feb 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509589; cv=none; b=lWQa+yW18hWtC/5UHQEftUoB1Uk3yEqXrFG5uCAY7dwhrzcJnSN/ckjjwzcp/5whPCDTCbJkljq80DAjSKOdMvDDiGJRXUNM2AIRGhEdOVB0uw8c/aW0lxZhqN2xoeK9Y+Jw53mscrQ/vWb+CpnRJf74+xEqDyt/GRCeM3fbRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509589; c=relaxed/simple;
	bh=5v3dtSCXtJMKznIfq4bOSd2Ajb7Xgfbqb6Og5lUaIsE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=lr7cwgxVUqP7/+ysSs3zUlX2uq6r5AQgX4BJTufLKBKVj1biWIj19UcgmickCRp6heQ+Pau8LzydYE6hkuCsc9vTSnMSyYsflcKcnKaAVqyLG5frtYy1HqFa8Ju6jJszsyQ/ir7mBXxdQvqWFajnb3LvEY0CZuOiz6sgUayeE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVHjyzqL; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso6775895276.2;
        Wed, 21 Feb 2024 01:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708509586; x=1709114386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5v3dtSCXtJMKznIfq4bOSd2Ajb7Xgfbqb6Og5lUaIsE=;
        b=UVHjyzqL4FfMFP3qCrtJ0vbyQTpYTd4T6aWiJWU9qEolZ3ta9AQlaZ4Kf8nBiuR3A9
         I0b88Stl7eHiGP7ofPTsbOHe9MXwWd69dkbda3P88wtmQ8eer2pZvVsS8l9rSz7OxvHS
         wVfzvzXZ+16ulyziWLRIk7r5FLdnhJe1O5UOxflrYrpJ/B15BbvcckExDKd5bE96NhkV
         V6T8KjxmLEKtbLpK1pgbhoPLZYmdVDSQejv3XDKgnaxucog2P7jr8TRoUMD7CQ3OYdp0
         FptaXXA2Gof7kVYuk6/9W1FeZUkjaHruRSR5n2x0VpqlCQewXflHWZT9z9f+F0GDx0ZV
         5rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708509586; x=1709114386;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5v3dtSCXtJMKznIfq4bOSd2Ajb7Xgfbqb6Og5lUaIsE=;
        b=nQ80AofoWewdbdu0KTaF4VzwEKb8ZzjeWUuw08P6NRclwrFW8LDaaFOLkqoix3xh4/
         EwPhEwauzXL8ddlooe8Yi9fkELKn1rEtJfnEhBNtVEf6ILiERjVD0Ox7LW9aLDACWJh3
         3SQ3bT/pdj9fsE3E3LcP4WUH8AFNRuWmhLyCl+6WKGBKj9zYlpmn3jp/bZN/44U0qKmx
         BcsnGgDIUiFPrtKnLAJiRr85vD8l/7I3p8ZW9ueXVXbiRz2dsB4erEtekoE+3RRq+z8h
         CaXMra67f/80wpx/kWG2KZnyUcBDPp8/cVQ8NGzvw9rOgNakaDu9VaMjdV+B8i8chOWa
         8mMw==
X-Forwarded-Encrypted: i=1; AJvYcCVVBOa+ajhdaZiWOYpiwn2ih9P3KsmVj5Z0B1X8/iFp3jhDT7p9lhoAoFxTNQeNndeX4m2bsEkdCJdRns8XTEYe6pM8h66Ivw19eA/n2x4sqGBwFJhgv++y9yhOk6sQpyKUT5/yaeKJ9zJid2QjmSkTbUwGQ6FRV0YL397REoxgxA2mi8pizvhtaDK+7Q==
X-Gm-Message-State: AOJu0Yz1LcIC/y+AZAemECrqSzbja0xx9R+KNEPwiSjykXghB9u7IWi5
	hktAEKAaPoOwlci71/z0+reu9/f7pPzAOuPIPzYGSVoGEJ6P3z7a
X-Google-Smtp-Source: AGHT+IGayboSSYCRSBTfKt/p8uzubL1dQkldpRG0mhTDMp+YvZDPIeXz2+mtkKwMRQEU2KIbrXXU8Q==
X-Received: by 2002:a25:848d:0:b0:dc6:be64:cfd1 with SMTP id v13-20020a25848d000000b00dc6be64cfd1mr14423533ybk.36.1708509586648;
        Wed, 21 Feb 2024 01:59:46 -0800 (PST)
Received: from [127.0.0.1] ([106.221.238.184])
        by smtp.gmail.com with ESMTPSA id u29-20020a056a00099d00b006e0e3e44f33sm8396473pfg.103.2024.02.21.01.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 01:59:46 -0800 (PST)
Date: Wed, 21 Feb 2024 15:29:39 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: zhangwarden@gmail.com
Cc: jikos@kernel.org, joe.lawrence@redhat.com, jpoimboe@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org, mbenes@suse.cz, mpdesouza@suse.com,
	pmladek@suse.com, shresthprasad7@gmail.com, shuah@kernel.org,
	skhan@linuxfoundation.org
Message-ID: <ff1078b2-447d-4ae7-8287-d0affd23588d@gmail.com>
In-Reply-To: <B052E4A4-3652-452F-B4F9-F36860143CC3@gmail.com>
Subject: Re: [PATCH]     Fix implicit cast warning in test_klp_state.c
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <ff1078b2-447d-4ae7-8287-d0affd23588d@gmail.com>

I checked the source code and yes I am on the latest Linux next repo.

Here's the warning:
/home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/=
test_modules/test_klp_state.c:38:24: warning: assignment to =E2=80=98struct=
 klp_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
=C2=A0=C2=A0 38 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel_=
state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^
/home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/=
test_modules/test_klp_state.c: In function =E2=80=98fix_console_loglevel=E2=
=80=99:
/home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/=
test_modules/test_klp_state.c:55:24: warning: assignment to =E2=80=98struct=
 klp_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
=C2=A0=C2=A0 55 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel_=
state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^
/home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/=
test_modules/test_klp_state.c: In function =E2=80=98restore_console_logleve=
l=E2=80=99:
/home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/=
test_modules/test_klp_state.c:68:24: warning: assignment to =E2=80=98struct=
 klp_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
=C2=A0=C2=A0 68 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel_=
state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^
/home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/=
test_modules/test_klp_state.c: In function =E2=80=98free_loglevel_state=E2=
=80=99:
/home/shresthp/dev/linux_work/linux_next/tools/testing/selftests/livepatch/=
test_modules/test_klp_state.c:80:24: warning: assignment to =E2=80=98struct=
 klp_state *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
=C2=A0=C2=A0 80 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loglevel_=
state =3D klp_get_state(&patch, CONSOLE_LOGLEVEL_STATE);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^

Thank you for your help so far.

Regards,
Shresth

