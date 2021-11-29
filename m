Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB8462876
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 00:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhK2XnL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 18:43:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55250 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbhK2XnK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 18:43:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C041B80E60;
        Mon, 29 Nov 2021 23:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885B9C53FC7;
        Mon, 29 Nov 2021 23:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638229190;
        bh=XZ7LcGOskihEgBQmxcMhcm1apI6WJBkoJGJKM66dLlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2B3PxDIvYb/c0+Lm53R/xw09vcyyWSYRf7fJUIyebXvPn7vuTAFeZLZGxdDLDwMO
         buipaXKG4mEl5xcNKVkhxBiITtG2jIQ1tYOIt6i8Oo5cehe/G3ljg7YGCuHOB9vw8U
         RpxOPrG2FNRNaAMHTY3gj32fV5OkYhJqKq/0BHtI5NFeyCInc2SFwX4DC93T1fzv3q
         Mp46Ujp+nSEhC6cg5hmvAK6R+Y3Lzv35Rx55Pdyk24RkPUna2kR9I/TcjxDP6eydha
         2BiUvHUpac5VorfUDrLR67Jgn4sgW/cXRBFTldS/jSlfdFEWk6oY3kl7z4Pjv3ynwm
         9sBp1SZVwuYVQ==
Date:   Tue, 30 Nov 2021 01:39:47 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] selftests: tpm2: Determine available PCR bank
Message-ID: <YaVkw5dnCewnFybR@iki.fi>
References: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
 <20211128041052.1395504-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128041052.1395504-2-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 27, 2021 at 11:10:51PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Determine an available PCR bank to be used by a test case by querying the
> capability TPM2_GET_CAP. The TPM2 returns TPML_PCR_SELECTIONS that
> contains an array of TPMS_PCR_SELECTIONs indicating available PCR banks
> and the bitmasks that show which PCRs are enabled in each bank. Collect
> the data in a dictionary. From the dictionary determine the PCR bank that
> has the PCRs enabled that the test needs. This avoids test failures with
> TPM2's that either to not have a SHA-1 bank or whose SHA-1 bank is
> disabled.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
