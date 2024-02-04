Return-Path: <linux-kselftest+bounces-4118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8997848DF0
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6391C22973
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5478821363;
	Sun,  4 Feb 2024 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzpXdjjk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E524B24;
	Sun,  4 Feb 2024 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707051833; cv=none; b=mZLCzOlOZumLCnh21nlrWKHv35x6D8csePPu25SB6EAyQMOEs12qo+TN2Ic7mcY79juKnfAff1hYUh00T38NA3mct83OFAlXKL0s/91AovaAAZqu6dXf0WciWMWjABbhBiU5325E5+MmlI0PYgsJu1nC6xP/+zw2b98ztptfQDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707051833; c=relaxed/simple;
	bh=33qb0lTFCLf4rU2I1xs5+TJ0LIK/mHIS088j2jXFTQs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=J/uVJ4f7o/RwDWwxl3tAAmtJ6qj9CjH0TKKrV17L790mdoaE5GWbKLzRYXYK4FIrzDFGJWnGdxAkmbm3NVkSmc1y7CTJkxThvfq3BG4x5jVSJJ7PnFJqjqK3UcVw6VuibonqnLxhVXAYKRMpby9kPfnGlZj8qPPzsHlxQoUaV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pzpXdjjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB75C433C7;
	Sun,  4 Feb 2024 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707051832;
	bh=33qb0lTFCLf4rU2I1xs5+TJ0LIK/mHIS088j2jXFTQs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pzpXdjjk7o1gSecRwrYV0VNSFQfoFsjJfXsczJaRmLQHs2J97J8JS40VYzB80LTt7
	 hpzvZf3ZqEyF5GWUI37cFm9qbKuvk8VA64GLku+lZGQs3XztYjK2WvVd/6cBpubZKe
	 Sv7QW4ryDF7n7hKaQEa80K4b1ASfAKxn+zj7rOVrXBSi2N7pwtTVeRl7V8xuoQikM1
	 sNUeCqmtoXGkW6D2/j/6PQ6rEd0DKZBfH0WtTgCcN7kUpqMfRlHVebvjbeb1l0RPUq
	 vKS6ruR7vBLBKXVUN3gLl4MOgqO1XAqXcEfXzqeylYW5vrLppT1uUGDmCWR9R3Ozdt
	 idjYd/GaggK8A==
Date: Sun, 04 Feb 2024 14:03:51 +0100
From: Kees Cook <kees@kernel.org>
To: Rae Moar <rmoar@google.com>, frowand.list@gmail.com, davidgow@google.com,
 keescook@chromium.org, Tim.Bird@sony.com, shuah@kernel.org,
 brendanhiggins@google.com, dlatypov@google.com
CC: tytso@google.com, gustavo.padovan@collabora.com,
 ricardo.canuelo@collabora.com, guillaume.tucker@collabora.com,
 corbet@lwn.net, kernelci@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [KTAP V2 PATCH v2] ktap_v2: add test metadata
User-Agent: K-9 Mail for Android
In-Reply-To: <20240126221426.4173112-1-rmoar@google.com>
References: <20240126221426.4173112-1-rmoar@google.com>
Message-ID: <6CCB5F6D-EC6C-452A-9D25-0D7B3F9739AB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 26, 2024 11:14:26 PM GMT+01:00, Rae Moar <rmoar@google=2Ecom> w=
rote:
> KTAP version 2
> # ktap_test: main
> # ktap_arch: uml
> 1=2E=2E1
>     KTAP version 2
>     # ktap_test: suite_1
>     # ktap_subsystem: example
>     # ktap_test_file: lib/test=2Ec

I think it's a mistake to mix "diagnostics" lines with semantic lines=2E S=
ince the diagnostic prefix is [# ] (hash space) how about make the test met=
adata lines be [#:] (hash colon)=2E For example:


     1=2E=2E2
     ok 1 test_1
     #:ktap_test: test_2
     #:ktap_speed: very_slow
     #:custom_is_flaky: true
     # format-free stuff goes here
     ok 2 test_2
=2E=2E=2E

> ok 1 test_suite
>
>The changes to the KTAP specification outline the format, location, and
>different types of metadata=2E
>
>Here is a link to a version of the KUnit parser that is able to parse tes=
t
>metadata lines for KTAP version 2=2E Note this includes test metadata
>lines for the main level of KTAP=2E
>
>Link: https://kunit-review=2Egooglesource=2Ecom/c/linux/+/5889
>
>Signed-off-by: Rae Moar <rmoar@google=2Ecom>
>---
> Documentation/dev-tools/ktap=2Erst | 163 ++++++++++++++++++++++++++++++-
> 1 file changed, 159 insertions(+), 4 deletions(-)
>
>diff --git a/Documentation/dev-tools/ktap=2Erst b/Documentation/dev-tools=
/ktap=2Erst
>index ff77f4aaa6ef=2E=2E4480eaf5bbc3 100644
>--- a/Documentation/dev-tools/ktap=2Erst
>+++ b/Documentation/dev-tools/ktap=2Erst
>@@ -17,19 +17,20 @@ KTAP test results describe a series of tests (which m=
ay be nested: i=2Ee=2E, test
> can have subtests), each of which can contain both diagnostic data -- e=
=2Eg=2E, log
> lines -- and a final result=2E The test structure and results are
> machine-readable, whereas the diagnostic data is unstructured and is the=
re to

We even say it's unstructured=2E=2E=2E :)


>+prefix must not include spaces or the characters ":" or "_"=2E

Why not _?

--=20
Kees Cook

