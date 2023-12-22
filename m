Return-Path: <linux-kselftest+bounces-2363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CF481C7D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50204286630
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 10:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2272F101FB;
	Fri, 22 Dec 2023 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lL34I9TW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6362101E6;
	Fri, 22 Dec 2023 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=5A/7DWiQyqPF64i2PEtKJ85mmlmlSCimVC8q5meWoRk=;
	t=1703239759; x=1704449359; b=lL34I9TWuY9MiZG47nhsfvIFmQyUk4K39yw+sAuov2c+kls
	bXKsHNy5My3dWkEBrJk7GenKzbs+Rwn+kpdsX5SZdbu9qrA1hSrhumrvTwcygFnocuYU6JhIBlq+h
	jg27mrZu7d3zjCi2FIr05GnEO67SmjZHAkjGWr1vs7NroKbbWs3trOKe+3DQXFBAg6k5vcWxQwAF4
	bgkcii+bSZxBVpe3bhyR+T1f78YO9t1nDgA0SaNJ7/pXqyDZE3f6qpACfsBNnRKjjkMD2f32TAFeg
	illX8Qw2Ey8Yt/3F1jqyiZS+WbXLEy7VA4ed6kuEVqYv5IYO4xA/sDMDsWEau54Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rGcSt-00000004AJP-1NtX;
	Fri, 22 Dec 2023 11:09:11 +0100
Message-ID: <2a508793563c46116ef8ef274a9fa3b5675cd7b3.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: benjamin@sipsolutions.net, linux-wireless@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Brendan
 Higgins <brendanhiggins@google.com>, Benjamin Berg <benjamin.berg@intel.com>
Date: Fri, 22 Dec 2023 11:09:09 +0100
In-Reply-To: <CABVgOSkrhEYXvzjtWfdxmKVGZwGnJTKwbd9+kBSRWxbOfyaRUA@mail.gmail.com>
References: <20231220151952.415232-1-benjamin@sipsolutions.net>
	 <fab3c87ea726208cbdec03dfd61230e4c8ceb694.camel@sipsolutions.net>
	 <ae651d3d-58f7-40de-a625-4882cf0efc9b@linuxfoundation.org>
	 <dbcadbe4430cd314373f15a9f4b814e44662bef6.camel@sipsolutions.net>
	 <a2ef9ea4-00e8-4fa4-bc2e-58fbec306503@linuxfoundation.org>
	 <CABVgOSkrhEYXvzjtWfdxmKVGZwGnJTKwbd9+kBSRWxbOfyaRUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Thanks for taking a look!

On Fri, 2023-12-22 at 18:02 +0800, David Gow wrote:
> The two initial KUnit patches look fine, modulo a couple of minor docs
> issues and checkpatch warnings.=C2=A0

I can run checkpatch (even if I can't always take it seriously), but do
you want to comment more specifically wrt. the docs?

> They apply cleanly, and I doubt
> there's much chance of there being a merge conflict for 6.8 -- there
> are no other changes to the parameterised test macros, and the skb
> stuff is in its own file.

Right.

> The remaining patches don't apply on top of the kunit branch as-is.

Oh, OK. That makes some sense though, we've had a number of changes in
the stack this cycle before. I somehow thought the tests were likely
standalone, but apparently not.

> I
> haven't had a chance to review them properly yet; the initial glance I
> had didn't show any serious issues (though I think checkpatch
> suggested some things to 'check').

I can check.

> So (once those small issues are finished), I'm okay with the first two
> patches going in via either tree. The remaining ones are probably best
> done via the wireless tree, as they seem to depend on some existing
> patches there, so maybe it makes sense to push everything via
> wireless.

If not through wireless I doubt we'll get it synchronized for 6.8,
though of course it's also not needed for 6.8 to have the extra unit
tests :)

I'll let Shuah decide.

Thanks!

johannes

