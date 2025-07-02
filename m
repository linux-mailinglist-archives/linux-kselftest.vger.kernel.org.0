Return-Path: <linux-kselftest+bounces-36354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315F4AF601D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 19:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9964A8179
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DBF2DCF5D;
	Wed,  2 Jul 2025 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv4t9T92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56751E633C;
	Wed,  2 Jul 2025 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477837; cv=none; b=lGdYDPbbsSIvdv9qFj54CjYyrZMJu2Z/4qoFHegrZPhKUyLX5QU4JtDbvrNM5Ntv4hiaKhQ2eatHs4Rq7Ze+TuZ63xDGQkCd0rcDarRZd0acPZivoOOCbN6k/gEVj0xmakq1MGVmtbPmzDqUawxtIfbr0vtc5b0XAUK/yKvdt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477837; c=relaxed/simple;
	bh=+3iu10ARXrli6aYGeWMSd0G/SI4ynrsF78F10CwdKD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYd/Ix2ZmHR5UR06Uo7FoYInEwurN0FUxC1TJIJIfIwJx0Dek+ehAPfPAl+cd5BiEtltyGoKWQkWIsd+IQOQazGisaCBzX4HE8eVxjnLtXJmPGlsvvLioYsE11iMBYmhgNB4AiRpIo10W2s1pYB8pJ3E5FKhwZ0I1pYy5iyT1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv4t9T92; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8276224c65so6286536276.0;
        Wed, 02 Jul 2025 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751477835; x=1752082635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3iu10ARXrli6aYGeWMSd0G/SI4ynrsF78F10CwdKD8=;
        b=Xv4t9T92UPQNgMKyWg+UGwLUUfQ/W1/TiJlt8BROqImgwFN7yxCFw8n6dMRtFn4r9b
         U0uKfE0MkBmQU0S2MWY6Y6DimRqYlddKEZn43S+fW1c864qNZ66F5DXfh2hNd6vZ7lzO
         HqM20c6UFOiFBveQro6ebibefKxr9rTGNT7Muj5U/pjfKyj8zhHb0QBOecju9jA6vnHk
         pT/gCVURa4xY0HRfTFFI2Y6FZ+P2MoAOkYot04HK76kZaF7HqDQStfGd2Xg8/50FeVxM
         TYSUEbJzFGlTfdScujz0dfXWAkt9tvvnHPFJyJhItdUfjbUnEpJ7Hdzr1088O2AMMsJm
         zs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751477835; x=1752082635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3iu10ARXrli6aYGeWMSd0G/SI4ynrsF78F10CwdKD8=;
        b=nd42mbpl3PSd8NvJH07cLY/yH3jF8gD646S1UD9SEE7zyDmyeywm/I1n6Pmsc7igDM
         IbxoVKE2YIbv8eigLnf60vIKkhERWPoA1CQxFlPH6akDqgWnSZWuqGVd/KbMcuCPbY2M
         73y9kpX86uJzq1oGAw5z7o7SASL1e4qm2JoIS8EEY9sib+lzUffnyg4f+R5VeXDBFXGq
         Wk9Sw/Zb0jgdnePuQjWp7j6fo7ggGLJt6CXetkyBalqyBXaFLqYEEtaj6M6gH5SlN88/
         O/f2cPVjKDdMETVQcIdhKG8+s9rqb11905MB1ngRecpIA7IVumwgLa+w1+T4y9YKgndt
         bSlA==
X-Forwarded-Encrypted: i=1; AJvYcCVqk/Orp5VuB1ZvT4A95WZYhaedhn8dBHhY1W+FAR+N9yFm0ZYXjWDW4awtnl9xn4evaYjMKYCixRFsvT1t8pod@vger.kernel.org, AJvYcCW5V6MiA3ALUw/YD3E0w036p6vGMAgGNk14TNih1xehRW0ijwSNmE5/c50uTfCi8KKnTUzCS2VEaRElSVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4saYm/m4lAfQ39NguE++ixMzN0TucdZnhtJvIsKXl0PbVY/zC
	S3YMP7S0jAwE+jtVijQo19C4r0Z1KLZOgIGKx5+UcQ5CHwkj1lCXwW55Tn8FwObhaeHklIYiCMk
	vzLC6Vcr2PNnlgNjLrCtoSabkZadrXbTDHQNBRUM=
X-Gm-Gg: ASbGncv6lSTXp+kyesWDC8RWTEt6EzgUcNTHJnudWG4SA3D3wDE+TBWxbFX5dzXSkMW
	D4heicoeCiVO3SS5t2s9NaLOdVUsuE7dsW40n20oHlDc0NOIbmOC6GmFTw99XBo6MGaJ3k02dV0
	p23/5er6S3ygqdGskp2VLmRBFUyqlncpdM39AnC4itberj4b6NTbRtO1+b+uPFl2GqcuZ9OC83W
	V0d
X-Google-Smtp-Source: AGHT+IG65yWaIH+GMe5uFx9j4slTz+xcfrbtnzt86UHGCPNc2S++CK6rMAk8qWiyENa3BvDVqurWq+l2oPlvEZC1Mro=
X-Received: by 2002:a05:690c:6886:b0:714:3e9:dd3 with SMTP id
 00721157ae682-71658fbcc71mr7959357b3.6.1751477834545; Wed, 02 Jul 2025
 10:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
In-Reply-To: <20250702171704.22559-2-moonhee.lee.ca@gmail.com>
From: Moonhee Lee <moonhee.lee.ca@gmail.com>
Date: Wed, 2 Jul 2025 10:37:03 -0700
X-Gm-Features: Ac12FXxSvmf-vd0t6RoDD8VwiJfrWPOWXyAk3_FBBMmpe3i4cdXWTYiNc4YjfZE
Message-ID: <CAF3JpA7q6WRMNar-EqOd6afTogyiUoRq+GnWp0sdv5rakLpsYw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/kexec: fix test_kexec_jump build
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: kexec@lists.infradead.org, dwmw@amazon.co.uk, mingo@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 10:17=E2=80=AFAM Moon Hee Lee <moonhee.lee.ca@gmail.=
com> wrote:
> ---
> Changes in v2:
> - Dropped the .gitignore addition, as it is already handled in [1]
>
> [1] https://lore.kernel.org/r/20250623232549.3263273-1-dyudaken@gmail.com

Just noticed I had the wrong address in the To field =E2=80=94 the correct =
one
(skhan@linuxfoundation.org) was already in Cc, but sending this to fix it
properly.

No changes to the patch.

Thanks,
Moonhee

