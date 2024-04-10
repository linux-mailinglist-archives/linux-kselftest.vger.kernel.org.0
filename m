Return-Path: <linux-kselftest+bounces-7515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F1189E6A8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 02:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EE81C20C41
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 00:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504F372;
	Wed, 10 Apr 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3D1SZ/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8C1182
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Apr 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708064; cv=none; b=PXhhNlcXOWQt3cXQN36eUkeyIy/5Jy+bcK6BGwpbmYxPXmlgoNwD2DSH16AiSXFSsO+LPY7f8Z8ZkLLycs2AKX5NGrdgeGvvXilUFgJnH9a6R5NAIk/HlndEmRvhvD4i+TJhUu0LNjB2sGORKgzCufrhN4gv1tsH2oL69Bd36Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708064; c=relaxed/simple;
	bh=hylFjz6L+qK3LEVxEOjE2ZqRGFqT9dpT501eKt8B9PA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ls0rmk149vvBMtCDAStyHP1Vz87dQCQPUbL9YtGtGHhbrL3JYCWVlY68lmc1FyQgDzzExMrsqfYWdQRLFsu/DCIvrl6PY4I7olvMyKpgmZD70fSPmMrjdsMLMs2/izGo6UIuTRwjMcAdW51PJ2h4mDADMt0IbWJvGtXbZFK8CzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3D1SZ/t; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so10312250276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 17:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712708062; x=1713312862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIbdZOv/vPHtFRzVH0oN0bjB08U1X8E7O8JyibswoCk=;
        b=x3D1SZ/tm/b6lcE9oe75iRwX77MvvB+e0T+DR4Xme8AcZHUUWGYtZdklaP/LifLzHM
         VUhc6nuQuufAh2mjYyN0bNa2yh03h9PI7ACLlmB687eDxVNy5z4DXD/YqMFNBMNVnMgc
         zP4HeEceBlOL3KrEaGBrQONMGVA9DMhUCuV56xN+AZaT4QajHkOWjPH7ycJk9UhaRfN3
         WXXIS/NClMxdK8UKfqbanDLDQfIhAmtWYIzclEjsmkTB3PcftmRBVeXWL5LcUC2ZKt7C
         cCpfgbgrZkqj3pxzmgNt12DhJ+9Rm2Y01jatMPtEDjNQZhZ3LSCB3wMyjQB6T6eb6Lid
         /O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712708062; x=1713312862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIbdZOv/vPHtFRzVH0oN0bjB08U1X8E7O8JyibswoCk=;
        b=R3Pji9HsCQp+tD43RCE+ij8YpoOIUIyuBvisDSBKh7n/XTLL29qqA2gw8jwxj0sHA1
         NIXYzShJLBbT4vE9XK9St2LluUrKUzTreAVuupMlL5F24Orw8JGx8oWi9tMHh1jaIwLY
         CIdAsvDprDgU+hbc8MTtPiuBYLXW0Z3YPGMMfB7e8pUEGL71u9QMp7uRbOCWitcR07tv
         7eH5QtS6qi+DNmI4Zvj/dqt6DrHU8za7TzhKDzENhmeXYZZlKaFleF/myJ1mq8w7t1yq
         7CF3dfAgxtwEGWrrkA38VV1ilYkW97SsaUNWXaF3YlD+fRZ/UrFi07AzfCg9s83Ltfbc
         +a/g==
X-Forwarded-Encrypted: i=1; AJvYcCXjkPEgCVzpllDjwJPopkh9h5D5ZHXh7PBmCpWpC8Qqf1njloM1tlTPGBIVSqkC71j4hqQmGjkMP5fEA0ZtGZUGE5stMvvNQaZLfhelqjPU
X-Gm-Message-State: AOJu0Yz71ysd5E6oHjam6vbL0aqgtup1HPDn+g7/+c7uFtk65T37OIS5
	vkSwualzK9eP30Op0wg9Bn0HcrYR5BzXGZ8OJfKzV4TjTsPGEunhtA5fe/SVaXTIGaEpY+oe0b1
	JIQ==
X-Google-Smtp-Source: AGHT+IGGO4GWmzQYviQp1CVozWMLXLtrysbsNAF3g8Mrch1Hg1xHRMGTrIYNUcBplo2kcfvLH30UdpXAvJU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:f82:b0:dbd:b165:441 with SMTP id
 ft2-20020a0569020f8200b00dbdb1650441mr387148ybb.0.1712708062334; Tue, 09 Apr
 2024 17:14:22 -0700 (PDT)
Date: Tue, 9 Apr 2024 17:14:20 -0700
In-Reply-To: <20240409160920.3bfe3eeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409224256.1581292-1-seanjc@google.com> <20240409160920.3bfe3eeb@kernel.org>
Message-ID: <ZhXZ3BEcbtoJKPFM@google.com>
Subject: Re: [PATCH] selftests: kselftest_harness: Print empty string, not
 empty fmt on PASS/FAIL
From: Sean Christopherson <seanjc@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 09, 2024, Jakub Kicinski wrote:
> On Tue,  9 Apr 2024 15:42:56 -0700 Sean Christopherson wrote:
> > -	ksft_test_result_code(t->exit_code, test_name,
> > -			      diagnostic ? "%s" : "", diagnostic);
> > +	ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
> 
> Have you tested that to make sure it doesn't change the output?
> 
> .. warning: ^^ leading question ;)

Heh, I was *this* close to adding a blurb saying this was probably only compile
tested.

