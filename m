Return-Path: <linux-kselftest+bounces-9810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A21F8C14B8
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D862228213B
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB077F46B;
	Thu,  9 May 2024 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/YeDd6q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAA07EEED;
	Thu,  9 May 2024 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715279252; cv=none; b=HmupC87WgJytB5j4jfAOIBoZCGqrQCQOH3TOe5gimlYw7n5zPn1mJOk6VROccgxE3BTtpKKxrzw69qp+J4pihV7X3xoAmzbUuXaFjuhrmGhuTtD4dDEhSa/bgbshdJQN8yxvqvvZKomHAvKXj0hS6e6ywJswRj9Afi4fFSK+dHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715279252; c=relaxed/simple;
	bh=oOtrruVuIXcJ/Qhu15JDv9pl+fkbhxBHX+8JLsyNYeE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kv9xaD4nl/GZk4BSffh/uhWMZjyF+g00tww5cBPEgGWRD9H3l17VX4xgSyro9pM0gL7xEwxCij9bvfbb0u1qXwH2gKu4YH3rsCNpiqybT0VIQuZ6JXzkjDoTDw5pKxSZzF9uoEeTY7AKSJtZg7/IS+xRAjvupvJ7boVj5yPSzGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/YeDd6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D729FC116B1;
	Thu,  9 May 2024 18:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715279250;
	bh=oOtrruVuIXcJ/Qhu15JDv9pl+fkbhxBHX+8JLsyNYeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K/YeDd6qOXMJ4qXJfmOVCfJMPzi1ZWLXBg8BXRkuvFhONEv8XBlw5PFHfTBqum1o6
	 torWu9raTXp6XhTmrZQop3fBha9TYKqTqhANzVSXlWx/T6p5qG4pAfVud403XpvSMb
	 xJ/42HEwa1pDEe2HbeAjitZLpMQ/U/eQiuMxzPG1N4JqZEbiTc1TfX+F238jdIlFjD
	 h0gdDWmrR9vtfdq8N6OUXbIg3CURyQPuYQXX4lJ+4F8ilrlHlHSY68WidQNZQmjmQY
	 Jbi9NLRzI732tcRAuqUvO0SuwW+fwq662ISOtfpV+5r6GiPZ0ZwmNPjgoqmHi+ifBM
	 KUPad+ANGXyOw==
Date: Thu, 9 May 2024 11:27:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tao Su <tao1.su@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, edliaw@google.com,
 ivan.orlov0322@gmail.com, broonie@kernel.org, perex@perex.cz,
 tiwai@suse.com, shuah@kernel.org, seanjc@google.com, pbonzini@redhat.com,
 bongsu.jeon@samsung.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, alexandre.belloni@bootlin.com, jarkko@kernel.org,
 dave.hansen@linux.intel.com
Subject: Re: [PATCH] selftests: Add _GNU_SOURCE definition when including
 kselftest_harness.h
Message-ID: <20240509112728.6670264c@kernel.org>
In-Reply-To: <ZjxaVEKv7bEuHJ8c@linux.bj.intel.com>
References: <20240507063534.4191447-1-tao1.su@linux.intel.com>
	<20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>
	<ZjrpieLKXFhklVwR@linux.bj.intel.com>
	<20240508070003.2acdf9b4@kernel.org>
	<ZjxaVEKv7bEuHJ8c@linux.bj.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 May 2024 13:08:36 +0800 Tao Su wrote:
> > SGTM, FWIW. The print is printing a test summary line, printing more
> > than 1k seems rather unreasonable. Other facilities, like TH_LOG(),
> > should be used for displaying longer info.  
> 
> Thanks, do you think 1k is enough for test_name?

Definitely.

