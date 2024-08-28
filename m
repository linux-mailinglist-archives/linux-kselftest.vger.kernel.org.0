Return-Path: <linux-kselftest+bounces-16566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D2962DF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5410C1C219E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DB1A4F1A;
	Wed, 28 Aug 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IswJapzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C91C1A4B84
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864332; cv=none; b=KzqH1HmiAIVSvF8h+gyOfwSFm4T7Kscg86JRdfrJUpj4Cf1xgFJYYSnJNoWeQlurDUYw52v4h9qfK5o2jcy/AChKq2yWcsNSOWK8XhtsH6NJ7H+VOcN2RNDp9LGqxbD4esF7+tmb5A5gtWJQrA7KWbr7MtOCurCVJX4TO4ij13w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864332; c=relaxed/simple;
	bh=p1rVlL0Yo6vgPkwLIWFh+2Ugki2GlLVSpE2CQl8AIB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPUiXA+NI+r5ZnwhH7FC2cuNHflbPGNvNzjiz17RnO7w3c9CTWdXfdJGg8ldjyDjTRVrHbmfDq1vAfqnMQIGYlBdg8gfAaLUKm98LZSEHjq7GK0Hvn6ygkbf7lbS2NwKRfjUrPYqb6JTyMVH1yGDt7pcqICBilUsLpXTxa9Uchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=IswJapzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9219CC4CEC7
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="IswJapzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724864329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1rVlL0Yo6vgPkwLIWFh+2Ugki2GlLVSpE2CQl8AIB8=;
	b=IswJapzn6Gwy4PIOF+5FMFtVgtcXTpQDZEXu7QMn9tJlVhZE4iMJuSGY4QvlAxvvNMg224
	AWUbcgpkl0QRB2U8H1ximoy4aQeVZWUJ9mnvhReypnWscFfSq9aip3HwkgSMlojo51Unji
	ZDiEKlVa9H64FndDQFFNZ1P0uI5QmWQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9b1f783 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-kselftest@vger.kernel.org>;
	Wed, 28 Aug 2024 16:58:48 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3df0519a3ceso100062b6e.2
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 09:58:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxe09Lfjl5daYiIoMRbyYosOJhnetYGJj0OPF/Lx61T1CDs/pP+
	l0wOPmm//vLw6Ff162Nqovws3UzSpsR92k38wWdAZ5wJ/iaseQc2W/+uaHjm38aRCBhuX7PVA74
	JOgwTczGOmOjAHToBDEiTcTWyxCk=
X-Google-Smtp-Source: AGHT+IFRDvI3Wbg0iYLiJlNQrdgpo9ZfojhnorKREwMdw47sS57hCLAU46DWLkwgiF8QEX9NiLMjBCRX3naAgBjECZ0=
X-Received: by 2002:a05:6870:2891:b0:270:1352:6c1f with SMTP id
 586e51a60fabf-277902b2b47mr218552fac.33.1724864327253; Wed, 28 Aug 2024
 09:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828135510.3414909-1-Jason@zx2c4.com> <64761aa8-123b-4eeb-890a-855d0a0f8755@cs-soprasteria.com>
 <Zs844SsY-zP2kSTc@zx2c4.com> <5102deef-663d-46ea-890a-6efc8e451f68@csgroup.eu>
In-Reply-To: <5102deef-663d-46ea-890a-6efc8e451f68@csgroup.eu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 28 Aug 2024 18:58:35 +0200
X-Gmail-Original-Message-ID: <CAHmME9phkdWKK-UOdGz5JfEqk1JGUPbj84axZdmPTJ6XiGgfXg@mail.gmail.com>
Message-ID: <CAHmME9phkdWKK-UOdGz5JfEqk1JGUPbj84axZdmPTJ6XiGgfXg@mail.gmail.com>
Subject: Re: [PATCH] selftests/vDSO: open code basic chacha instead of linking
 to libsodium
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"xry111@xry111.site" <xry111@xry111.site>, 
	"adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 6:54=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> The only thing is that you must describe this behaviour change in your
> commit message, you can't just let people believe it is a one-to-one
> replacement of the previous test implementation that used Sodium.

Good point, will do.

