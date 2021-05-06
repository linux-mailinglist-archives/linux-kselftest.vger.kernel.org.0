Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3E374CEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 May 2021 03:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhEFBle (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 May 2021 21:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhEFBle (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 May 2021 21:41:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DB00613B4;
        Thu,  6 May 2021 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620265236;
        bh=1pKFro0/3gf1vpcO8GXtIw0LJio7IKjnXmLHvnZn9O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IakkTYEonAxswkGmPEmfUcIzVO0ZxrsAy53FlU/l0AMp8WivyQYijOHXGGGg/9Sg2
         0Bzko3fBBzfw8wMa470H3s2z4kXxC4V+WPQYC85kJqpozMzSLjPVjc+q3us/VLbUmL
         AZmMiiuU5eidMly7G+2XE3iUhAkkMgYARM1/4COSp2xm+04jASzw1kRc3NsueK1COK
         V/11x25SJfee3DBbVB5KRcUPEgkVjSz9kOErgVJ/rH0ZHGUGJ1PkfV6mlIYXNd1K+k
         ORQP9H7YkFQHB8epYkgivVcFbV6zNI+okYOECNUFQxDPo4KZD8DzknFGuvcXzrhQ6B
         sziPuq8JwzHNg==
Date:   Thu, 6 May 2021 04:40:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-sgx@vger.kernel.org, dave.hansen@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/sgx: Rename 'eenter' and 'sgx_call_vdso'
Message-ID: <YJNJEszTCIKgMa78@kernel.org>
References: <20210506013201.126612-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506013201.126612-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 06, 2021 at 04:31:59AM +0300, Jarkko Sakkinen wrote:
> Rename 'eenter' as 'sgx_enter_enclave', and 'sgx_call_vdso' as
> 'sgx_enter_enclave_unclobbered', in order to better self-describe the
> meaning and purpose of the symbols.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Nit: I think actually t these would be clearer names:

- eenter -> sgx_enter_enclave_vdso
- sgx_call_vdso -> sgx_enter_enclave

/Jarkko
