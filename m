Return-Path: <linux-kselftest+bounces-13090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FF924B9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 00:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E861F231B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C011DA337;
	Tue,  2 Jul 2024 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpyn0E7Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D211534EC;
	Tue,  2 Jul 2024 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959649; cv=none; b=ozBfbTgsfd6LAfWy6roXbnjEBZorOOwXs04sYqegwP/sFFqsUn9ebgFfCN+mi3yewWlHCRJsstxE4AY9B8QcuONfB61Gsb7w56bJYTUuyhyi/GSr/9AO34dOnaxU1BS1nnH32a3AU5pM2ZK3HlzoduSh+knXB8tvMpMhUeqwUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959649; c=relaxed/simple;
	bh=KziaBpEAnsGQT4426rxprJX0UZ5Svmw7gJNav8yVDx8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=NONu3kOcPq06hNy7N7udI7+aCE9GspMJuHokdcrP/EXplEh9zjqLmnTMJnMf7VHEH0Yrx4g64hawbNrb65gj/Hc4PCJgoZd07pkGoF6LdtB/E8pPxfAiknsoFIP7ifi0dpOSXZWL+pMgNrB/f60DcTk8yP3whmEisVx2kLVlb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpyn0E7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0D7C116B1;
	Tue,  2 Jul 2024 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719959648;
	bh=KziaBpEAnsGQT4426rxprJX0UZ5Svmw7gJNav8yVDx8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fpyn0E7YjwwJUhV2q6LCTGilkzbAbNEXkwLJu8+XKwSAZVm+a0KQQzogJoYU13m+H
	 /kk1ES2t1s5OgJsLNWUkGXZWtKPcDbi/v7uP/5euzlUbhBk4noZQjlIkbLKVdpyuJC
	 bZaJ5okQhkgdUg8QDp4fQPcdgO3VEUbrhcJKDh430JNu3Wf6G7scQp7nsRiN2Igb37
	 LJ78FnSB8hXkKTgXuXu8YD8tsgARGycPuvxLszSr0DGPAwmnkqaWoKDyFOY9Qa9EmZ
	 unBR08YpjmK0jBfvhI6ySiAZzu1Xq6DzxVlwk9D7vNPlD6ZUKLrSByvzjXCwTLMdzR
	 p2fObXfa2UjeA==
Message-ID: <a41e68b927b0a1bc864673583a54d736.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c88fbeb65cfda6c568b4d8d69215139f.sboyd@kernel.org>
References: <20240603223811.3815762-1-sboyd@kernel.org> <20240603223811.3815762-12-sboyd@kernel.org> <CABVgOS=4Qnb7pvc_mmkPGdyVFGNWU9wdyn9p-QBKKG+rbJGtfA@mail.gmail.com> <c88fbeb65cfda6c568b4d8d69215139f.sboyd@kernel.org>
Subject: Re: [PATCH v5 11/11] clk: Add KUnit tests for clks registered with struct clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, patches@lists.linux.dev, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael J . Wysocki <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Daniel Latypov <dlatypov@google.com>, Christian Marangi <ansuelsmth@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <maxime@cerno.tech>
To: David Gow <davidgow@google.com>
Date: Tue, 02 Jul 2024 15:34:06 -0700
User-Agent: alot/0.10

Quoting Stephen Boyd (2024-07-02 15:25:47)
> Quoting David Gow (2024-06-13 00:56:08)
> >=20
> > We should use an action wrapper here (KUNIT_DEFINE_ACTION_WRAPPER()),
> > as casting function pointers to kunit_action_t* breaks control-flow
> > integrity.
>=20
> Got it, thanks. Maybe there should be an of_node_put_kunit_exit() helper =
that
> does that and can be used anywhere.
>=20

Heh I already have that with of_node_put_kunit(). I could add exit to it
for clarity? I don't really care either way.

