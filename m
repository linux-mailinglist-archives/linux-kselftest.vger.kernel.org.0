Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFA266821
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgIKSQF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 14:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKSQF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 14:16:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24F4208E4;
        Fri, 11 Sep 2020 18:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599848164;
        bh=i14ptXZFBYl1B5AOpNIChw7dOLx5tjH3OtuCFpSt8/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2egjIzmKBZEfyGZO8bVFMN+EqtHb7EUjvSQTb4ABF/Fo4ReeEUoykPigmxc67S8iO
         uFFJsQOAJRF7Ns44zgmDjYbtECmRjJVkS8etEGUy6Bt4GoXyDcqHrSgXrHaY4Mdo2t
         AjI4ZZYzxleQQcKbGIg4is1vqX+1EgIgDs38cVrE=
Date:   Fri, 11 Sep 2020 19:15:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Boyan Karatotev <boyan.karatotev@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        vincenzo.frascino@arm.com, amit.kachhap@arm.com,
        boian4o1@gmail.com, Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 0/4] kselftests/arm64: add PAuth tests
Message-ID: <20200911181558.GA21319@willie-the-truck>
References: <20200831110450.30188-1-boyan.karatotev@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831110450.30188-1-boyan.karatotev@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 31, 2020 at 12:04:46PM +0100, Boyan Karatotev wrote:
> Pointer Authentication (PAuth) is a security feature introduced in ARMv8.3.
> It introduces instructions to sign addresses and later check for potential
> corruption using a second modifier value and one of a set of keys. The
> signature, in the form of the Pointer Authentication Code (PAC), is stored
> in some of the top unused bits of the virtual address (e.g. [54: 49] if
> TBID0 is enabled and TnSZ is set to use a 48 bit VA space). A set of
> controls are present to enable/disable groups of instructions (which use
> certain keys) for compatibility with libraries that do not utilize the
> feature. PAuth is used to verify the integrity of return addresses on the
> stack with less memory than the stack canary.

Any chance of a v3 addressing the couple of small comments from Dave on
the third patch, please? Then I can pick up the whole lot for 5.10.

Cheers,

Will
