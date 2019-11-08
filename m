Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E11FF3D26
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 02:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfKHBAZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 20:00:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbfKHBAY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 20:00:24 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C35602178F;
        Fri,  8 Nov 2019 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573174824;
        bh=jRakB92CDtqhebD1jrBrh1EUmgiQvq5dv4RO4lG0uak=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T0b/+HM0RC9jlc/Xq50EtnaAkPrOya0KFpSixIVIYUh/F1621mTGaIvUiYRMaVaHq
         p7TbDiSV4dyCQTF4eaYDrdu+eLPXk06EZF6uGhOHGqB6B2gmTZk+crUjzrP5Ugpe8W
         FpDssw4Hr4zEx7BBp21XV7vK+1ysSHLc94iSChSQ=
Date:   Thu, 7 Nov 2019 17:00:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-Id: <20191107170023.0695732bb67eb80acd4caee5@linux-foundation.org>
In-Reply-To: <20191107195355.80608-1-joel@joelfernandes.org>
References: <20191107195355.80608-1-joel@joelfernandes.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu,  7 Nov 2019 14:53:54 -0500 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:

> F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
> A private mapping created after the memfd file that gets sealed with
> F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
> children and parent share the same memory, even though the mapping is
> private.

That sounds fairly serious.  Should this be backported into -stable kernels?
