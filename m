Return-Path: <linux-kselftest+bounces-15266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC25950DA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 22:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85F61F25D27
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 20:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34EB1A4F26;
	Tue, 13 Aug 2024 20:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3uNeCVc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F151A4F1A
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 20:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579797; cv=none; b=GUyJCQupMMSXHf9R0xsUJ1GDJzB05sIrJfsyFcv5vuoDM3hLgbC1GeqIJXefcYeLel25lHTB7oxo7fQ5hbGG1cZApj2n4YBjux4W8NHR52vUNyBXI9fAFVJbulkJhYvy1CvTU60vnXebMzZfc8wTasa5Fyeamouep1aEGz4+d2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579797; c=relaxed/simple;
	bh=EeBG1ng3cz3ZtvrOCXa1ktZtE8soByIQHgdXDWQF5ro=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Wm6Nx1jtV7Ux6ixX90QVAsIlm7szoIkMpnyPa825QrEBCRhmns0BrR0/wCRRVkTIdGWEZ2dLMa4v6hk8pxlVNtwlRcUP4WWsNZlWvu8Byr7ou+hOjyhlOosE3b88pSUkON1Ra28dGnZkWXJvVM1XxKxmp9Y8UpMgZJSbQAy4muU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3uNeCVc; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0bb206570aso10478564276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723579795; x=1724184595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ja0CQrcVyhm6nr2lBka5ZD3vrcLqZGQb8a+gf69INrM=;
        b=R3uNeCVc8mT8ZJ6F93Z+p4NTgHpDqU8MXXv87/+NTRaC/WXhJMM9uVDGqKcuzlG95I
         Ch/ROFGg/PV1nJH2K9HEzmdZyU11JHWE+SEnSrMMQkYLGRNwbcJvwc+yHU+lKemCpjh0
         eR6/t2oH4akHocP6hznMUQxXPasyUljc4bHZVTFHjNJ6xEgz8GIRZaOzhPQRCAzKUnGd
         8S4eh6QTLyHpw0R6vqA6m8VSW+iDlrUhgSPXEAwwwiGqCjZv/VG+nbWFtSnCyfMnNAks
         wbfLTWkqBlZi7AP5q7yNnPVRTjRjEEnNyp6+bAdowdmZLyDYXZqVbSe1JrZKVMEcGQUH
         DXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723579795; x=1724184595;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ja0CQrcVyhm6nr2lBka5ZD3vrcLqZGQb8a+gf69INrM=;
        b=isbcCjg5b5XpApV/XGgnh/w1H1DfPxAaGDzsShluv3kxREXscyO3Eup48uXgEmLhc8
         X1YLpRTiM/R1c8SL5wXJtAO4enqXn0w7yl+P/i54xvJG6CSj6u0Jr1l40kmNFHcmVvvK
         dQvNBb4CcbUkshVYQPGJsYpe1lJLsjUCwyBSNv6xfsk9cZg7IEqa3VSE1Xeohbcg/jel
         ZiyEZEni4abZelMygcUzN6/9zQkdCSeJJ214j4j3GZyafsE3Hr2qTb6YTMr6Jix5JFNf
         jZ9oQugUQUVIoukhqenTJ0JcE6gsbpkLU4AqMxbuzm/e4qeLiE9ArVl/m7yXzY9ThhIY
         1skA==
X-Forwarded-Encrypted: i=1; AJvYcCWdNCOmc8JRfDw5ilKbQI/sEbscsUDN0LWCrnwSxkf8P44XQSZtfUxjy7oOwLRR+QSMYLaJa4DMpxC4swyNseaRhzDnnXMPU67JMrJ9+Q+/
X-Gm-Message-State: AOJu0Yz7Rjz5SSQHVx4jj6L1aU3By7U+Dfk+GycHi0LNtjBB8W3XorAl
	xaNK5kTb2EXJZvuPMxgFlbF+0ZNx1lPAZk95fllNVlT7dmydW0qVMQiAykjPmHxcQWrQh7owz9T
	1+6R2Q3SGZ75MPpuqQdz2Uw==
X-Google-Smtp-Source: AGHT+IHlxcyI37TL07ye4Yk+UR3MqCK5t0G+5VI5AgFVkOVLTTu7k6fZnmOS0WZ1N6sLhH50ilu0Ue66Cy6RcwPlYg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a25:d889:0:b0:e0b:bf20:4ff8 with SMTP
 id 3f1490d57ef6-e115585cf47mr26113276.0.1723579795231; Tue, 13 Aug 2024
 13:09:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:09:54 +0000
In-Reply-To: <ZruZjhSRqo7Zx_1r@google.com> (message from Sean Christopherson
 on Tue, 13 Aug 2024 10:36:14 -0700)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntv8049obx.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 0/6] Extend pmu_counters_test to AMD CPUs
From: Colton Lewis <coltonlewis@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, pbonzini@redhat.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 13, 2024, Colton Lewis wrote:
>> (I was positive I had sent this already, but I couldn't find it on the
>> mailing list to reply to and ask for reviews.)

> You did[*], it's sitting in my todo folder.  Two things.

> 1. Err on the side of caution when potentially resending, and tag  
> everything
> RESEND.  Someone seeing a RESEND version without having seen the original  
> version
> is no big deal.  But someone seeing two copies of the same patches/emails  
> can get
> quite confusing.

Sorry for jumping the gun. I couldn't find the original patches in my
email or on the (wrong) list and panicked. I will also tag RESENDs
appropriately in the future.

> 2. Something is funky in your send flow.  The original posing says 0/7 in  
> the
> cover letter, but there are only 6 patches.

Copy/paste error on my end. Before sending the first time I decided to
drop one of my patches because it wasn't useful. I copied from the cover
letter I had already written but forgot to change 7 to 6.

> [*]  
> https://lore.kernel.org/all/20240802182240.1916675-1-coltonlewis@google.com

