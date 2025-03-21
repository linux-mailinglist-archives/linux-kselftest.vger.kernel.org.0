Return-Path: <linux-kselftest+bounces-29567-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7EAA6BFA0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370EB1B6009C
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A5D22D4FD;
	Fri, 21 Mar 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ma++qsoA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YV296uVc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424F22CBDC;
	Fri, 21 Mar 2025 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742573831; cv=none; b=Y4N2CNEWOyRzASAGLwxQGj/NlC8PyJiOJI/x1MOHuMwMSp7SvDcG6hgHbV+KJ9vuMuFmu5fwYqboaJE1FcWjKtkpUaqsZiOpUpuKl4UfsIWLyYg25n7/fRPzWzSntG1EgtwFU3xN8ZAlMD49AwVsxCqhpozOPh5JqypRoLEkqmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742573831; c=relaxed/simple;
	bh=yOurrBEhT5MDzOHha8spgSCIqwdpbNSWC0FKLS3UBME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dcoBDMJqF3j6orHWx73O48eOKMiDPBuRNW0hBXVaiPPD3eONFXmx0ObArxjDkNJ57+r+FBbY/2y677kcDHwFk++WuJXNSZUAXQZu4jzVqZckml/ZF/BB1d3+KWxwawUIQ/z6zjwFZKtsD2n7y8o1xvoUjXopCycvAHAtYfRnBP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ma++qsoA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YV296uVc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742573828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsfN36ufpY7hZlv92ADdbBnqVAz0FcqQjRuAVY6SlFc=;
	b=Ma++qsoANoH0sP76p8Y59fH9xesh5kvavIpUuZOkUFtkNtjBnkE1mQHlKWo7HmlgQlzW7W
	xjIoYScUTpvTfqlPaHbwU6bHx2pnSA0UGzIhq6XWMHwTKMvT5OoIqufUz7Y/hHykg1CXww
	LdCwqJWnyH6PGLM0ix+bSkkHdsKn095+3/xUuQeXs+hqEUdQD2KAYHqfuzAaIJV/BvEmnh
	fgsCkeO52gS/jsEAXOjxP8u7mKPM3Uqbh9k9VrVlLqhX3q5U/CKnR+knXYmfriyULHfaIg
	faybE0iYKNaNuzLeOb09aOo05WRACz886VKiC7Xp4ubGYmXgYVd70xiSN3xb1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742573828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WsfN36ufpY7hZlv92ADdbBnqVAz0FcqQjRuAVY6SlFc=;
	b=YV296uVcjFYpysXEYxnmxfvZqHZ7njt7IA+mAqMy/z78ebGZ/FYxQvX6ECY3tDaYpd6fd0
	SAHlIxyvOM/4WoBw==
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, Miroslav Lichvar
 <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Subject: Re: [RFC PATCH 1/2] time/timekeeping: Fix possible inconsistencies
 in _COARSE clockids
In-Reply-To: <CANDhNCrxmoK98pmL-ynPVu9tMpyrjMXZ_L7-R0nV2r=YGMg0OA@mail.gmail.com>
References: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
 <20250315003800.3054684-1-jstultz@google.com> <877c4q5c9i.ffs@tglx>
 <CANDhNCqzHYJfaap5-TYPmtbaPm6AkS85hKdeSnprhEqMCAYcPw@mail.gmail.com>
 <874izs66el.ffs@tglx>
 <CANDhNCrxmoK98pmL-ynPVu9tMpyrjMXZ_L7-R0nV2r=YGMg0OA@mail.gmail.com>
Date: Fri, 21 Mar 2025 17:17:07 +0100
Message-ID: <877c4i2wak.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20 2025 at 19:01, John Stultz wrote:
> On Sun, Mar 16, 2025 at 9:56=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> #define TK_CLEAR_NTP            (1 << 0)
>> #define TK_CLOCK_WAS_SET        (1 << 1)
>>
>> So it clears NTP instead. Not really what you want either. :)
>
> Hey Thomas,
>    Sorry for the slow reply here.   So I agree with you that we don't
> want to set clock_set above, that was my mistake. But this last bit I
> don't think is right, as timekeeping advance() just returns a bool
> (return !!clock_set;), which is used to decide to call clock_was_set()
> or not  - not the argument passed to clock_was_set().

timekeeping_advance() also uses the clock_set internally.

      clock_set |=3D ....
      timekeeping_update_from_shadow(..., clock_set);

timekeeping_update_from_shadow() evaluates the TK... bits.

Thanks,

        tglx



