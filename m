Return-Path: <linux-kselftest+bounces-24127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A16A07606
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 13:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FDC3A1C06
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 12:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53D21858A;
	Thu,  9 Jan 2025 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvRoZwRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C52216E37;
	Thu,  9 Jan 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426780; cv=none; b=p1wvoSrurTnxMlKA8Z9xtup9LFsos73aYlYs+NpEVYPlSPbQiOzuY0ClfMMlDVkG86hm75x0ZLVRqJ39+vK3Y6KHCrsapo2/J1LF3EJ3/YrWlFjGq4o87+Ya2IN4gLMqKMENBOSJSP30vt6g2iy7FzyjR42zx0nu6CrMRLGCwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426780; c=relaxed/simple;
	bh=nOOZA+iN0ga0CTphyM/C05+qgOczZ68TEd0WLotUewg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KLmbaAeFCp6TgOP0r0KdtNF5ImN+Wb50AgQZO8ihSXNF+lsZN6JV0RNYJ0Z/m+QvY4sj6x6M1VNr5yhs+PuimaAv9xGBCtaRiDBNQR4kWymGBbqJSNJN0TqWGYENUV1ulFjMkyKThZfD0R9tCJgxuLeEIldf6B4/V/gW09lJH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvRoZwRM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b85d5cc39eso87453285a.3;
        Thu, 09 Jan 2025 04:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736426777; x=1737031577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaPMLCUZXOj8V/TsoKhneA/pbfWV2N1nHu6od460Xzw=;
        b=fvRoZwRMvr5M/MLiHu4/wjKv6pIXRtlIZXjCImm2KGwBN8zmaSX1NjxlzebJvvr/QK
         enQ+pTbyap/SMJmZKseFnH27xnx7GQAUpwXV2RveO2tBTzDcYtFKn8Vrqx9hSeg5Pzew
         Ta6PQ8sesIuV7hE+h46OikRUBwoqHodMahXI7xAphfnDlZeZ+1pF+49Lvr2SaoRIiVq3
         BLsB4FZR6+uc1VsvswzCgquThpNrvI/BcqEM89Pu2PmDvPgMVHR+OV1IN+HXWDHiToXL
         48K0w4y53Hh2LoGhH/UNgrZGRBG10DKbmpc8Qum1Vc3NcChXiJ25eMs+iz3dxBwE2Sl/
         wh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736426777; x=1737031577;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kaPMLCUZXOj8V/TsoKhneA/pbfWV2N1nHu6od460Xzw=;
        b=wX9UYrGAhzRzaVioXKMg0g6DAfet2PVRLBNpJ5xSopSBM17/T3bg2ZAXk8Rfn30Ao9
         3mPsJG7u8jD23NoC91/dh+JPKS3O+7zZUftqkmSViCi+WtyT/segvJO/IJ4zbs7uIEre
         0+XcDIP4LZjmcF4/ks/tmDnTSXiYMjyltABnHVau53+wwm7rb7v017xCNNxVEoweGHbm
         z9sUzF+BmAdn+5UWUD6hTUsGi3SDDPuMFWcer+M+Olc0yWi1VpiSLa9PykVb3tR4NDOG
         8FgywiGrXTm/zZqbz7QaebpckzN3rXMCIROAPEl9KAq7la88KRr9czjKfbWoSS7/EjKK
         U7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCURWYcFuaNu6VJZwalB584a/mzeDyRc6h8UCC1qguwoR3ou4HVZBdbXPfF/hGyXEQJJefWVnwqaPvm38zTVTXjK@vger.kernel.org, AJvYcCUkaJFEShQ0LhXToNzOloP5CekWcGzGXxFQBIjWF2s/6EgFSk7KrFA2azE8Kbh9XxfLruA=@vger.kernel.org, AJvYcCUrlRjwYs2JqEXVDKlCCQodaFAJ2fTZVu4EBJ73Og+VCyd0aDIVZfc04UhaoVk3vSz2QHcf6yWcvpNBqFA+@vger.kernel.org, AJvYcCVYZhGyEyxCYhYLSbYaRaWVB537feG/zIYcbJIWW1PJMC8KhuOwgYgouT7Epqz+gDSgy+5fK+ni@vger.kernel.org, AJvYcCW6IY0XLhpA0mIIvp0FWZ4/Uq3nu+4LsHD4h1VvVnxe+TCl8wswai4hq4UT4OuemTiThInFpC/oZx4I@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00mAZAtw1hhDB44QuHsQaxhOIAaWXBu9aRkcS1wPyIRAq6iQw
	hckMKAdFePZ3lftHb/mDQz79lEu9j3/McUJ2Rrtq300827xAgWsZ
X-Gm-Gg: ASbGnctRW9bcYo2V9/31gJ+TVIQIV1D13IbG9vqGdgInL2ZC7z8PtGzs7W4f/ihBDHz
	onFR5Kbl4BypUTARCK7ejXQBCVBHHGDHSTMgQ/dTkj7rFe6P3cqbru3KZuZRNcQN0gZiSbHKQIG
	d5Ebkd8dj7ONdwcl1hs7Orm9v+UVp5lqMGV2wUS38bTrWPpJ+IHrerBUttrcc7ZgBYC1IEj8lFL
	+PPywj39KDAqgHkHEOdkfxZI6a3XSSTCTI+9SjMhRhk4OvRohuV7S4uWKveI4+V4hoXLjnGHkQH
	pXkIcCxUT1AGMVgVXvSKI6A8nlyZ
X-Google-Smtp-Source: AGHT+IElltpq0Se5BPymgSR44p/+E1b35WmaB/SUjKp4ksNe7YwiYRSh+K5j9T3I6qKRunWydJbAbg==
X-Received: by 2002:a05:620a:444f:b0:7b6:f1be:4f7e with SMTP id af79cd13be357-7bcd9755084mr912637385a.26.1736426777023;
        Thu, 09 Jan 2025 04:46:17 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516068sm62500685a.100.2025.01.09.04.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 04:46:16 -0800 (PST)
Date: Thu, 09 Jan 2025 07:46:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com
Message-ID: <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
In-Reply-To: <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> > On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> >> tun used to simply advance iov_iter when it needs to pad virtio header,
> >> which leaves the garbage in the buffer as is. This is especially
> >> problematic when tun starts to allow enabling the hash reporting
> >> feature; even if the feature is enabled, the packet may lack a hash
> >> value and may contain a hole in the virtio header because the packet
> >> arrived before the feature gets enabled or does not contain the
> >> header fields to be hashed. If the hole is not filled with zero, it is
> >> impossible to tell if the packet lacks a hash value.

Zero is a valid hash value, so cannot be used as an indication that
hashing is inactive.

> >> In theory, a user of tun can fill the buffer with zero before calling
> >> read() to avoid such a problem, but leaving the garbage in the buffer is
> >> awkward anyway so fill the buffer in tun.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > But if the user did it, you have just overwritten his value,
> > did you not?
> 
> Yes. but that means the user expects some part of buffer is not filled 
> after read() or recvmsg(). I'm a bit worried that not filling the buffer 
> may break assumptions others (especially the filesystem and socket 
> infrastructures in the kernel) may have.

If this is user memory that is ignored by the kernel, just reflected
back, then there is no need in general to zero it. There are many such
instances, also in msg_control.

If not zeroing leads to ambiguity with the new feature, that would be
a reason to add it -- it is always safe to do so.
 
> If we are really confident that it will not cause problems, this 
> behavior can be opt-in based on a flag or we can just write some 
> documentation warning userspace programmers to initialize the buffer.

