Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F19C3BB6A9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jul 2021 07:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhGEFNS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jul 2021 01:13:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhGEFNS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jul 2021 01:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BACA613DD;
        Mon,  5 Jul 2021 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625461842;
        bh=X3sKGO9OLoaijCxEl47ZmBU+3j5SvmlkgdJFWqCuGq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3B2rpoD1ne8QFdoBKtnJo6aHtEDkEVxnsrQwiAGO2yjDVEQt6gvD96uxvtagtZNz
         cNJkakalDZeoXLmm7aUtvLlopxI1zG5SmwTD4m2wHufPTFAPOi+1Dj/t43XbNUHBKN
         Ep7pd72+ZON6A0IAzXLE4pSeouEHOJyZfX5E/g84mKlgaff96lT5+HZWq9dEKnJ5P+
         NH7glhHdOpmC4hgLaOZ6w7khyEG9UTmLtCt++NilEsza8wk2p1ncxAdKBbipZn7nl0
         aCMZz4x2gCWXcvL2y2KPsBfW3K6+sAsoDOGu90EGSZdP03ikkWKJCKIE0AAmprCv+m
         TN0cQ4JVIoDGg==
Date:   Mon, 5 Jul 2021 08:10:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-sgx@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/sgx: Fix Q1 and Q2 calculation in
 sigstruct.c
Message-ID: <20210705051039.npwagq2xd2r35v2u@kernel.org>
References: <20210705050922.63710-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705050922.63710-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 05, 2021 at 08:09:21AM +0300, Jarkko Sakkinen wrote:
> From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> Q1 and Q2 are numbers with *maximum* length of 384 bytes. If the calculated
> length of Q1 and Q2 is less than 384 bytes, things will go wrong.
> 
> E.g. if Q2 is 383 bytes, then
> 
> 1. The bytes of q2 are copied to sigstruct->q2 in calc_q1q2().
> 2. The entire sigstruct->q2 is reversed, which results it being
>    256 * Q2, given that the last byte of sigstruct->q2 is added
>    to before the bytes given by calc_q1q2().
> 
> Either change in key or measurement can trigger the bug. E.g. an unmeasured
> heap could cause a devastating change in Q1 or Q2.
> 
> Reverse exactly the bytes of Q1 and Q2 in calc_q1q2() before returning to
> the caller.
> 
> Fixes: dedde2634570 ("selftests/sgx: Trigger the reclaimer in the selftests")

Oops :-(

Was meant to be

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")

/Jarkko
