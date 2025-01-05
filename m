Return-Path: <linux-kselftest+bounces-23921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664FA019AA
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 14:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC93162646
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Jan 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9101145A07;
	Sun,  5 Jan 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfAFQ7qc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD1849C;
	Sun,  5 Jan 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736085278; cv=none; b=J7iSWth4R0v5lzB6sSt6jSSMmcXrOgfcMJWfcpFjfvkC03TM+J1+MTWIZSjrffXjK91orZd8UaaBjuTDTSdSvHjhEv89hgeoARgAerRBvH8xjxP7/6TgbAWpFn/waxuTFtLuzj1R0+PW22VXAEwvITw9UhcTlMU8Kie1NnPbzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736085278; c=relaxed/simple;
	bh=3fxk3OnoZkN1Z1f8Ji8vmU8OCT1AMTuKhEIc0DPCTzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZQSZO+99J4UmadZ6fmgbqQQaIXMQJLab6AL5ooy9hOnWYme4c3sYM405cbE8E1vHQem7eTQg4mMvjB0s2xZ8Tfh5lZS+wF4+7eriRjHVjPPu0KlhBeCKT6IP4GHeH8eSUhJl1geAF5ogMvye4q5HmkpY7nOZcgBgnHRGlyW8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfAFQ7qc; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso2863705a91.3;
        Sun, 05 Jan 2025 05:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736085276; x=1736690076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fxk3OnoZkN1Z1f8Ji8vmU8OCT1AMTuKhEIc0DPCTzA=;
        b=kfAFQ7qcXCNNne8kWdv04iwHPXgZWxcwqp9v1utjZbXXVVBUtJyi/9tNSPZGc64/Jm
         UQN/V2KIiz0ZDBilD9HvUaVdnocd7Nb8k89VlxWMyZpm/Hh+wyVcr/95qyELKN9SxOhU
         IHYKS/L9ZduvYmV2wqtYdAYPdkpXM8xqDarK2VQSdp+ctdBjEfNCWb+ps+NgxRPDumA3
         UZH7tB5J2gh5Q35LWgvf1GYYANw7N7hHYeZGSx+Tx7tZzePSFgdKob5dqDC5n2PvQWiB
         vSVsonGjQQATDertOSmbOt5vNGFPqHufJCcU5GU1ftuUixaEzCK5A9PAipzlhhAGyund
         7rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736085276; x=1736690076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fxk3OnoZkN1Z1f8Ji8vmU8OCT1AMTuKhEIc0DPCTzA=;
        b=BXv3/ZgrqdZO7I9aLpne6ffdnkAmmblhHS1f3qnQAxRdUgNobb6nGN6jr7k6MdR9hK
         8W5IoIYgFT3+O7lB967/fGUq/mVgCRxvT20NOqAN731b8Zj78dCaSGZsl1aF7nR8tRXr
         1YR2PA7pJiRBsm3aOtzgLtAdLLopAF7Utip+jhdd8RkIBO3YROD6WOlN3xZ3Gj98JSMB
         AqJVWTQAnr5918IQy/HezXKbCPwRHeqnD9U1/+jyvkBeThjTzw6EQtdwlrL80GgVBDid
         FmOenYkrsryW9w399ap1qMneytpOYryZwaPKX58R3YV8Hn/GBmjJKoVewD9go1oismfj
         PsZw==
X-Forwarded-Encrypted: i=1; AJvYcCUxJJG1mphZEGXAgZHX8Hdedu7GTGacNgPYu6PBzdtF64Qf2HoqR6ANSiRykfidxkPygzHzG/0rsl+pJQWDXWU=@vger.kernel.org, AJvYcCVEES7Uy1P7G1coeG+wTNlELLEnGjZoR7K2UFyGkMngPBzF1DKvGhjxV4iyMc1okxNTK23GIdsHeIA2ayVYAmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lJRfDj6nPVDH/s3iPtqpsfmVA7v/38Kluq5JJBfH0c5+8A2P
	W6vv5dklOQAeRDnmS3QOmCMGZXFu3Wuk9SIEXZMMvDDlQUKEcd5exmG/0xbukJjS0oVXJ1520Ve
	tkrv1tk45iX2O4HcfSemrq7qgu4LCkQ==
X-Gm-Gg: ASbGncsAMfpjLSjShZgQ7G7K6oPvsWLOYBs6AhS2sjyEOIh9VqcbflcyWT1JvzbOXtv
	tn97YvoSpQVhsvRmuEK1GdAKO+W15y4QglZWggQ==
X-Google-Smtp-Source: AGHT+IErXFkVxv4dKvMNLHylfuM/owCnaNmH8+o/zslGc+qTc7wsP+OT9Qo+2SUcirlTsNJ11X42KBRVBb8wkAhSGlw=
X-Received: by 2002:a17:90b:2cc7:b0:2f2:a9bd:afe9 with SMTP id
 98e67ed59e1d1-2f452deb7a8mr30475176a91.2.1736085276598; Sun, 05 Jan 2025
 05:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvM96LS63Wa1+5Md9w0V0JZgBW+f50kzx9RjRCYj3aDkA@mail.gmail.com>
 <CANiq72mMo9fyw-NbLUQi_5jD68W78Q5ZMn-ubstWCa6hue7qHA@mail.gmail.com>
In-Reply-To: <CANiq72mMo9fyw-NbLUQi_5jD68W78Q5ZMn-ubstWCa6hue7qHA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 5 Jan 2025 14:54:24 +0100
Message-ID: <CANiq72mvp85d8GMcdhdmUAdoUci1-Pd6rNxrPg_THs=NKPNp8Q@mail.gmail.com>
Subject: Re: rust/kernel/lib.rs:17:12 : warning: the feature `new_uninit` has
 been stable since 1.82.0 and no longer requires an attribute to enable
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, rust-for-linux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Sasha Levin <sashal@kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 2:33=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Thanks for the report! I think there is nothing to be done here given
> the details above.

To clarify: v6.11.y is newer (and EOL), v6.12.y LTS is newer, and
older LTSs had the Rust toolchain pinned.

If there is something I am missing, please let me know.

Thanks!

Cheers,
Miguel

