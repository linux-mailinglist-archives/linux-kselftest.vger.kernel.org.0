Return-Path: <linux-kselftest+bounces-21259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EED9B83D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F16728209B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAF1CEAC6;
	Thu, 31 Oct 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaB2DkJ5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA501CBE8D
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404588; cv=none; b=fZgcpsTSL6bpqdaEUV/EG1NTPlEktuN63IFYrsKqmtG839Q7dezCg2j61Gx7rpj6yHFc1fv9rLVVJiCNBJGbEEp9I/JjfUHCMdI7yWeTiqNHoEVmSJkbXUPxQmnMLBJENyqNAslFIEPWbR8uKPA5mivQzhdXvZ5UsH9zqT4h9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404588; c=relaxed/simple;
	bh=irdmhu416PxIF988xDa7tIMGyvRLyDF64RSqw86O0Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sctgzBrPvzNhGDb9O/JhtKu6e+7hqUQJW3o/R2NGMJ2zJSb5Foad5Tvu3TksX3yybreU92jQFSTOtquN6NixeonpLlFnpUAz0ij0STfkzSh/daeVTDTdGwkdACwVZ5fFyVVJL7Y3caxPbNRHY6JjCA/wxwc5GHshntTBwf3BuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaB2DkJ5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea527764c3so29197317b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730404586; x=1731009386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcT/J95b+9035Ya9JfyYQ0TCrJz/IdJHOD9xyZsiM0Q=;
        b=BaB2DkJ5z11RKP6zMu2c5UAGueRrf1xWbbXDcBNXYQ+kZVdON7wr4WTuCLwzrX/XMZ
         YeLjnoMxbz99V7p3vdr1bvLowfxVuMiPq7+mp0C+UCppPg7VW9KDuCptMJ0KWxH1psQe
         fOHNaG4pHRXBro1+bgpqwMonH2FEo8qBmNcK/HveGrJxyvrJyjbf9nORfR/ksT37fooS
         KT4z/KBKpalFKSvw4uMNu3MesiwkOo05wkCUDk8oVA9u35xqfsrW2L+Y4o7pQelnvNad
         XKNwzjlZNAZaDjBsUmnDK+X/J4rBIGFurWv9mF9ZKrnkVAPalwlM838oyp7VYH61eo2G
         HI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730404586; x=1731009386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcT/J95b+9035Ya9JfyYQ0TCrJz/IdJHOD9xyZsiM0Q=;
        b=CJWkTrcrEKlHxFIPyK/49toulYoR1+170+RXY8UykwacUZiMcr2IVUZWvmPuj8dmYM
         WA/V6V+bywkuC9I2zikm5v7k7N19QXUQvpn8eBSCQcKXZrxjApCWwBsNJIYt7BaPL63y
         vuhrgdLZY0RCYFXC9iOCfM7CJbOAsLvpVtOeoye3miPIMs9iislI3I/Ajnw7b7L3MDql
         /AjOxcKo5uB+2FuZzNVRLXathNdUw3kfx3ALzf3fjQ9oHOtAH11NGZNeFom/l5O1tuak
         m6YXmf/Av9TFJ73x7pCWQ48b6MFXTUttTE/VvQ0NL6WML+JtRaHGKVTiot72O3pYQaQW
         C7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvDVsxDwYMeI5PMFgu4YKpVy6Q1GJoGcg1kXjC8BSUjG0Q17eisuENkZ08WaGq+fyOSTCHDoSQUkLnqh2YgQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmcXRtoeyN+FVP8SPTCU772rD2Hq/QAQmfjQi4WtpIxRKZQWr
	51HtsgRGt8MActqiDglGNEqiePLQoqME+eCMi9ntKnHkuvInNM3Ej03CP4jidCIvtyxxxMjBL2t
	vUg==
X-Google-Smtp-Source: AGHT+IEmEp8u0KUn1vgmjUZHb/5zJ8j0UI9051gpFeWX3hQBJbdaH3En+U7SxFv81ttx+3Vv7JsNluVX+3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6902:181e:b0:e28:fdfc:b788 with SMTP id
 3f1490d57ef6-e30cf4d455bmr5615276.9.1730404585605; Thu, 31 Oct 2024 12:56:25
 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:51:50 -0700
In-Reply-To: <20240903043135.11087-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240903043135.11087-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <173039502633.1508201.6734292194726141989.b4-ty@google.com>
Subject: Re: [PATCH] hardware_disable_test: remove unused macro
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, 
	Ba Jing <bajing@cmss.chinamobile.com>
Cc: shuah@kernel.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 03 Sep 2024 12:31:35 +0800, Ba Jing wrote:
> The macro GUEST_CODE_PIO_PORT is never referenced in the code,
> just remove it.

Applied to kvm-x86 selftests, thanks!

[1/1] hardware_disable_test: remove unused macro
      https://github.com/kvm-x86/linux/commit/600aa88014e9

--
https://github.com/kvm-x86/linux/tree/next

