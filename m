Return-Path: <linux-kselftest+bounces-25827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28000A28B34
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873B53A720F
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC2B282FA;
	Wed,  5 Feb 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="mtl58fj6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500F151987;
	Wed,  5 Feb 2025 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760829; cv=none; b=athmfWlcj7zSAMH4sfeyS9xkiJWQJjWJILGte0PYgugHglY1o4hYomX2Lwe3EI9X4oJcyUylbmGxJxmPmBB8HHoXtyVvHl4o8ArC6ERipRzZKDqUACoayE+BcA/R0Kdgmgx73K97t0Le3dv2wUyje03mv/39ZNke0Yx45ka/pZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760829; c=relaxed/simple;
	bh=7Dpyg+fjBS5ylwa6lXbkK1V1o4n3i/ba3X3ylj5JybQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RohiN1MA4wNwh6ll4DKTAoGckUXfWnHOFFJONek2w19DDSNnW8qblNrvl+YZXeAp8pScTXuGx26rKa3hbe7bCy/rjNRnMA+MIeVK+RCfLWx8ri0cPf0FJn95EKmCznB8w1/wAwOw24Y8x6qUZjWkNLNbZpHrrJf6CWKEe1qgOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=mtl58fj6; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738760808; x=1739365608; i=ps.report@gmx.net;
	bh=7Dpyg+fjBS5ylwa6lXbkK1V1o4n3i/ba3X3ylj5JybQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mtl58fj6P7YN1Icrwu83PO6rNmnIZ9ah16gFHY345nHAwKpWvC8JN3iF71W4DdCX
	 8RbCunBQDEiVhfBJEFB3xLhEAKRrivS1kTOnaTGBxRJ3wsBShDBUDiw0b+Qx8YETd
	 cjad/a3GaqwXdq3drQPNZ8d89YwQ3RVFwfqM1UWjBencjo1YixWtp2YXvPD7Bf+6D
	 W5lQADepBPi+BJ9ZSwY+tjPDf8CG6ep8dtTp5psmuZ3mk8SkRY8AqLb7Tvol6WPr1
	 hLZM6S8Qin+clQP8F6oWnBroP0xvEECg7+QvgOR82x9g0Wft0atqbrJygH3+Is8Jl
	 XLmvpHquPMi7by9w8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAfUo-1tZ2Ke0k5w-00H1EU; Wed, 05
 Feb 2025 14:06:48 +0100
Date: Wed, 5 Feb 2025 14:06:46 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Nam Cao
 <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 02/10] net: pktgen: enable 'param=value'
 parsing
Message-ID: <20250205140646.0fe82c6a@gmx.net>
In-Reply-To: <835481c6-0ac1-47a7-84b2-fa5a135186c2@redhat.com>
References: <20250203170201.1661703-1-ps.report@gmx.net>
	<20250203170201.1661703-3-ps.report@gmx.net>
	<835481c6-0ac1-47a7-84b2-fa5a135186c2@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tbV9nPQbiRGlbA+fs4RVJ9B39twSFqLEwBfkpWipL7nVRT5Mg6w
 Eezqo/GvVrbSZqjm+PE1y9ZqS95uGItndQ882qk5/SH1BCUls9qJijlPLiPQbAnbqhC9mZK
 nz6i5Bte33olIXuJr4N6Lky/scyB7M3e1Li/6ep6sWmCRdCwufi0dXLQk4LcjU3/sOxAWeL
 t5spVy9qsOtZLNDC0m1sA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aOEf9ahPHk0=;+k8BKBhOIzHUqia2z0wZq+VIiB8
 IpUbLlhMzf8/o0XR4FAGFM64N7kdkBevocoJdQIFTsje7zEBFxfBLYE/bzABI1hD5SvZyYHO1
 rxdCh6tFMQZxq6Xl8JxK8PTe3JHPlWcV2CgEFtOK4GVj+jMnrtR+r571oS+s2Dnnycwas6Qtz
 umkWZJLANMq5s/X48kG8is/rgnh6D8VmK0UI5L8YCdQPhUoT0uMZpQLbDUpkva3l1IrVPUjMj
 qWYZc42IDeCCy37tELJywVQfHJSHWROWZ3fkWHwm0R1PeBD59WEb5OcdTzuCn2Lr/HHZ81Wjg
 ++OoCnhbF7TZGeMkDrUmQXqoOjAMIHPcaz5kjoKpdz5BjTvNK0CDZjAiKG2Wt/Eg6SUMgGk8u
 iaCIifr05mvQ7DMll1ZmBmK9wlxyprXwIE6WEjCORId74zcOzEk2LwyLO202FnW93lN187FOw
 OcxL8AN92+3975hG5SrVov9d223IpAJR2MVipCZ1PpQv/+Ow0on+PGrxUopo6wrP96QLSqfbj
 QViQaq4gtBF53+mK1pGCJnPo1N70Q5iaYh5oRx+m/FfcdYB/yfG7EMGnDgObTxGOxy8Pm1jey
 hfI0NKjnCg0RdXxDB7Wp3sTyVz9JkGF0Y398UO67rGRRuAWkt3ecdN636BUXyr8ecZVWNWCV3
 A7RbvlIi6tehIw7Ikw8KonVOekvWfDS+quJNjU9wrUVw9HHNPuqu+/FTAXILWJLTQJmEJIbY/
 XzjesGtpbBexGRTKf566n6SC0Jumj6Qapf5q0SDGp4Mqisy5h6UC97EI0Pakqmjabw5EBG/kv
 gG03f4sTXOg5jaDyn0p55OUnORYPCOCGXYvJrdTnsvvldJW/qDMCs4tHaerYWC1QCwBa/Denx
 i1uvxZXSbHmwxLEeNHC3aujsqXnROWETnVxkoNsA85DbllQBTCNPHxCZE82gyJ4n4/CaL6/de
 X6gzqNbeiw85VWW6JJxPTSGL227Ubf3/lnLiXgZ3MHV9FTJG0fgYxPSg3md2CcVcV5p6SBA7I
 tiC3yeT4Vg8vnqcIMm0NMaw13DQPYmYSF1Ll50EFFSvdjFvr6gaStMLaVLP4oX7x+1fkrCgG6
 fBDhsxbZnrwAFL+x88qQzGz+Gr921NDZAXtedAxrwLVxkz3SYJByk2c9y06HG48120L+casNh
 EYA9R9n02YBXsHhO8EVPNEhSFGiFSNOADVVNUopUJLzw9PvFSykTYlNJjSCcW1OrsIY9bm5UF
 4fEU+1h7VmWOMyP6cF4IoSfg2u/0P3tES63k2BMl9dvob3ZLVd1hvEE9jcglSZsRddlm/ZMDJ
 5b2so2fiGmaTWV+uOI01dERTQRBJ9oDyPAUtjblXaVwkEURJE0Fs4X3SAcy6xnZjClV26GR+M
 076GIA7Z123WjQw5EZzsJBgqqGFN12Zn9oiOn6TN49Fn1wl90Gg9c0c+G9

Hello Paolo,

On Tue, 4 Feb 2025 11:55:57 +0100, Paolo Abeni <pabeni@redhat.com> wrote:

> On 2/3/25 6:01 PM, Peter Seiderer wrote:
> > Enable additional to 'parm value' the 'param=3Dvalue' parsing
>
> It could be language bias on my side, by I find the above statement hard
> to parse. Could you please rephrase it?
>
> IMHO something alike:
>
> """
> Enable more flexible parameters syntax, allowing "param=3Dvalue" in
> addition to the already supported "param value" pattern.
> """

You are right, thanks for review and improved commit description,
will fix it in the next patch iteration...

Regards,
Peter

>
> Thanks,
>
> Paolo
>


