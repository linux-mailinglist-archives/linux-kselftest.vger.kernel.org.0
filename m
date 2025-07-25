Return-Path: <linux-kselftest+bounces-37992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64810B120EA
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 17:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6005A1701
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jul 2025 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A72EE616;
	Fri, 25 Jul 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="nQqHSjAr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEAC2EE615
	for <linux-kselftest@vger.kernel.org>; Fri, 25 Jul 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753457236; cv=none; b=u2ry6iwo5s9k/Rz+Esc/cKeaiwOrHb7LP03+m1oWHKTI7mT1AsH6x4ED27At7QMrFJThcjSQJ874QmY8oA2LU7HaLM4JJHDdrPUpWcc9ZvyCROc/M5Dto8nNV0OYNfNzEJ2+Bbw/zoqCpvFnmkxfxWkbAp4elpZKYv2iEdODNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753457236; c=relaxed/simple;
	bh=4XUbrRL0YD1KlBsBsyBzOc11nCYHw2nNmqKf2Kh7fTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5v3nRcwY2jGQDxLvqe2nkC2xVHsoNEoH6Q1VLjKjcpU/mynWOJwmvMUiFkgvHpGez7w2G9Rou4OuiQIt6ULe7SmXhKCVrbntUUn5+ZkWBzau77Qos7v8uFIOaY2x1lNuA12GJCxrvZHB83///L4SV/d1RUHWY8xLxGffjWEyEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=nQqHSjAr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-187.bstnma.fios.verizon.net [173.48.116.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56PFQwjk026198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753457220; bh=By+urOWaG/ajZlSNQ/vduTd8yEF1RnUec8nS30xxTnI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=nQqHSjArwp98eVqDtB8jcbcV1+yiikon7Pd/RCZZz3hSzRmLvfrHwqpF0B65kvAJi
	 HMGuQj/XSH0eHLqheuzFe60fXjjmU/G7ASWatXSU344vj5vJ8GoxKelsQcuYmci78X
	 CgPrBUFWnExL3RUJYezEd+qfk4rZygCH1r5bWPci7zpLLr2YhJa23E/hbGJOSQXPNH
	 wZIZG/8pUk7m8fdU/ySy+nA1YLLxqd8O1D+rwchethvhgYrZ+FJx035R5bHZDp54ok
	 z61244xgVKkWfMNKVyzgYBRH4AeXdbOcHNKEs+z/utp3FY7z5TuuLe1J7tVhuiDRFG
	 UMxCvFbmOXEYg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 58DAB2E00D6; Fri, 25 Jul 2025 11:26:58 -0400 (EDT)
Date: Fri, 25 Jul 2025 11:26:58 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Crediting test authors
Message-ID: <20250725152658.GA236659@mit.edu>
References: <20250725080023.6425488c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725080023.6425488c@kernel.org>

On Fri, Jul 25, 2025 at 08:00:23AM -0700, Jakub Kicinski wrote:
> 
> Does anyone have ideas about crediting test authors or tests for bugs
> discovered?  We increasingly see situations where someone adds a test
> then our subsystem CI uncovers a (1 in a 100 runs) bug using that test.

I just list the test that discovered the bug and which was cleared by
the commit, and assume that the test author will get credited in the
upstream test repository (e.g., such as generic/750 from fstests or
inotify02 from ltp).  So it's not something that I've worried about.

I suppose if the test repository isn't as well known, or if the test
hasn't been checked anywhere at all, your concern that the test author
should be credited is something I can understand.  But it hasn't come
up for me.

In other cases, if the commit hasn't been stable yet (say for kunit or
kselftests coming from some other tree), I'll just throw in a Link:
tag pointing at lore.kernel.org.

						- Ted

