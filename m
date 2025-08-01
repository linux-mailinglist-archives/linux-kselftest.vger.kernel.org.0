Return-Path: <linux-kselftest+bounces-38182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F3B184EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B2E1C8254A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9A327280E;
	Fri,  1 Aug 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDoHhWs5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5012727F5;
	Fri,  1 Aug 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062052; cv=none; b=OaUulMDBo5DE9fFubyCYeLRnFa0b3citTDlTQQH6Y3oXn72L4CW1jT6fB6ZBsLITHYFOsses5EC/AOfg5wYqMGVECP3XCdf9L4nyIek8BIsviqpy88g+QC1gANoZZTduZ1vEF84m0G03dyJEvhs3/1R7qWLfE3fAoRdzhURDSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062052; c=relaxed/simple;
	bh=tPFNf88/PzuSkUeVAm5dy4etBtBV6c4QjPdPYxo9cuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSuLb+8fUtYiP36RjDX1XlFvC4T1uujqa3ae67t8DzeGOPP9CYNj8Ed1MTUoo5w4kPpM5rhfHoTobnBUgKVnc0vLYvOXawMsAwrJM3Pl8fZVboCxqI73Z3ivkXfuG3OwyF5A05uVNULm0ZDrGr9y4D32KqabMd5oj5PTfEol8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDoHhWs5; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-710e344bbf9so10789917b3.2;
        Fri, 01 Aug 2025 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754062050; x=1754666850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPFNf88/PzuSkUeVAm5dy4etBtBV6c4QjPdPYxo9cuc=;
        b=CDoHhWs5gZztermd/XytKgURFmfIAhF4y/YDfanYEdoU8s0iLICJhxX6oSOvSX9jHM
         WCKfhu/w/r56QzpScKg9Y2+pz1CVE3A0pd8Lh0J8NXQE+iP+P+CML9wvjB2pGRA8ADl/
         dhKEIHuSk1QQGTQjBnsOLApx02QKzzIO8mZ0moxIQUwV2m94WBfPgWCU0vsU0j6k62fK
         IbQmaIvEcMWzZbipIqL01DS53NjFYABzAqLpyKV2M/nFCVy/hWoYqNzSleZqcFvL6lqD
         Oupqzy6w7Id0y03VbMgNKm/g/re88ntF4vbyZaF9Y1JPCslnee5TRGNQWa3juMTKo9Fj
         ukLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062050; x=1754666850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPFNf88/PzuSkUeVAm5dy4etBtBV6c4QjPdPYxo9cuc=;
        b=qbntusHQMqr/upUJHv+/5Gc6J0i2FeBOBCKT8qeXp0SNBYztMx66qj6FHGy9kPJ7bW
         1jv70W4ohM7izx3Zg5323EUp7b7rI4rURiImSiS1YvwGQLxo6VzgtdPrhb+IZHGgVal6
         k9F7b6p4mBCED966cH+xdXB+qV1NO0KVn3ahyWvlycIr8e1KqkQFAZyZ823HOLbWC4O1
         fmX0R8lqKi45ILfNlGOvjtYVPQ/Sqb+MfddnphrrCmggEnmVOYYg0V6hq/fz4hgWwbl3
         jJ1B4tAdLG2BIEbZdYY3MQY5xPLDp/rJW53YOeyy0d1G1MTVi4OSDmjCfRYGofzWE0NO
         vlPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUne84E74TuPPUdb7figF0vZefznuBfmNQr2EtFSzm0XLLnci7zEXqPLBb6Z8grds5BSg7b6xdLeDt/mKXagSJ7@vger.kernel.org, AJvYcCVfUuqp5LgDpo80Ar1A9mch6/pgIy0MIbJyzAjSkoqdtdN1Tv6gDEo59LqL36AvKVxroWJlSP7X8FVTigw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9DaAHrF/QHqr8/IeQ2PlfNqZ/e3Jl4Kn1EH+SAd9E5YUmp21
	+fXEDntEdLuOHvpEn7LcJS77DponoZgDQre9tooHFzgkGmw3UJLoS4pHY07FUpkVKLIcjDowjJJ
	VBuZwJnJs/v7i/j2JaAt95DK23Jum88w=
X-Gm-Gg: ASbGncthEjndZ3SRTeqqJge+Pyn6wkUoYhiV13xSjIpN3fCBt0ssLUuNWtUxxc7sel6
	f6+cKqi1YHm+ANMFIWioattsRYs1m6ybqrSD3g3L6CfvDLwv17Lwbb9QNvQmRk+oZUSCt4t8qvg
	CoiueHGA6T8KT1ugictbVIsrpVx9qx/JuYftJgu5GNVAis7i+nqM5gbGHi6MZk6lWOY/sPCM7XC
	Bud1syI
X-Google-Smtp-Source: AGHT+IGtTnwydBRnNDx1iAloAetjLiySJJ7mxnI12Sn/8rX+pN11KBeKORsT1zOrEsLTa+z+33OXuzmdh2Ph/3TovVo=
X-Received: by 2002:a05:690c:17:b0:71a:1f26:5d1a with SMTP id
 00721157ae682-71b7ed84355mr855347b3.11.1754062050019; Fri, 01 Aug 2025
 08:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626191626.36794-1-moonhee.lee.ca@gmail.com> <c6272a2f-e157-485a-ab16-c3610a969a00@softathome.com>
In-Reply-To: <c6272a2f-e157-485a-ab16-c3610a969a00@softathome.com>
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
Date: Fri, 1 Aug 2025 08:27:19 -0700
X-Gm-Features: Ac12FXy7UTnL_9RJVqYwWc5gIlHD3mHgBEy5GMm-vXZBqx-aCsd2gBpkALaQ6BA
Message-ID: <CAF3JpA4G4+cHmthLYbXF1sSatQB8SCMe4YUa-kHZwAgAJ2rgtQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: breakpoints: use suspend_stats to reliably
 check suspend success
To: Olivier Blin <olivier.blin@softathome.com>
Cc: shuah@kernel.org, yifei.l.liu@oracle.com, zhujun2@cmss.chinamobile.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

On Fri, Aug 1, 2025 at 5:39=E2=80=AFAM Olivier Blin <olivier.blin@softathom=
e.com> wrote:
> Shouldn't you also remove the timerfd variable?
> It seems to be of no functional use after this change.

The timerfd is still required because it provides the wake-up event for
this test. Just before suspend the code programs a CLOCK_BOOTTIME_ALARM
to expire in five seconds. While the system is asleep it needs an
interrupt to resume; this timer supplies it. The patch only changes how
success is checked: we read /sys/power/suspend_stats/success after
resume, instead of comparing time diffs on the timerfd. If the timerfd
were removed, the machine could suspend with no scheduled event to bring
it back, turning the test into a hang rather than yielding a result.

Thanks for the review.

Regards,
Moon

