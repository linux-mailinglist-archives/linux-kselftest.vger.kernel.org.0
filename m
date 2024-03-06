Return-Path: <linux-kselftest+bounces-6019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB6874300
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 23:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3C11C21A73
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 22:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3D1BF58;
	Wed,  6 Mar 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFD37nTy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215F1B59D;
	Wed,  6 Mar 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765503; cv=none; b=maUAGO2F7TzfsRYqWbonTQmCvfXXR+bn3XgjF0k2WO8rawi9aMTkIfTC9qvttoJRIAS2EFQ/0jhBbIT5gOa0+2fBw6xKcYrpUFWMs5YTThqjRA1xzsv9iZGd/trvDbkCw1s0eosimoanQ9RSzdNmbG0rj3WgNjjNv2eSwFQFt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765503; c=relaxed/simple;
	bh=HNBDIUXB8ADe3S0CerOS4/GQYaPpXqbqYxKNF0I8pJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7qZrnR4z9JlzzfjQuhBqDCQXCvHfz10UKt/6CHucud8YDynPoY5R1XkSzD5OiHcjG88MK7GW0v9imVBWRZC4W3Cs25TpeftTQt3beTpUut+G9JcavCQh1Y8OgL8I/jmaGkcv65MEmBL2rZf75G4cc8XckM4FBLTGDMyIsOd70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFD37nTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845D1C433C7;
	Wed,  6 Mar 2024 22:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709765503;
	bh=HNBDIUXB8ADe3S0CerOS4/GQYaPpXqbqYxKNF0I8pJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GFD37nTysBPDZ+h/N+DQPS8ZoSVnEVzoQ0XSdvrhF2b/3QQn3w0ZRVcZ3DwOZrYsp
	 56vgJbJqyYShpt5m8kByYnY1GEUX6eKKARyMgLGvh/Bo7yEali0+eO1S8+wU52RkAR
	 b0ovhdHg7RhyJatRPlBVLSq8dpCqix6svtoI71LE=
Date: Wed, 6 Mar 2024 22:51:40 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Michal Sekletar <msekleta@redhat.com>, linux-serial@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kselftest/tty: Improve integration with automated
 systems
Message-ID: <2024030633-managing-identical-9b92@gregkh>
References: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-kselftest-tty-tname-v1-0-33505b31629e@kernel.org>

On Wed, Mar 06, 2024 at 07:21:24PM +0000, Mark Brown wrote:
> This cleans up the output of the tty_tstamp_update selftest to play a
> bit more nicely with automated systems parsing the test output.
> 
> To do this I've also added a new helper ksft_test_result() which takes a
> KSFT_ code as a report, this is something I've wanted on other occasions
> but restructured things to avoid needing it.  This time I figured I'd
> just add it since it keeps coming up.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

