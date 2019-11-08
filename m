Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7CF4067
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 07:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfKHGdJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Nov 2019 01:33:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHGdI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Nov 2019 01:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qCauJZ5vwFE0q6fN8aq4sFtrLeNJgvenOfvg0GpdMWM=; b=sG/5Iy/R93fNdCNserw/hcK8F
        I/tl7i3svTZIlLBYVvm+NfxSZjsLxC51ymu9r87M1bcceDqDqzElzGH4E21ZuKNGpCjCF2a3WhE5/
        aHceB75r4dDQHPWrsnertyu9LhreTunp6OttSkF3mfFAFB8UyZHLgY4VlFe3F3U+gU9tQP8euB1Al
        O41BzkChjzsSrgPwft5xFbCUSfvSdd+z5qjlvYD27PHjVupeohgKhz9l3sivmFUVj3CAW0v4MZZGa
        Nf+34EHDPZULFBQZufZmCw7CMWdZ50dwzhOF3TIDn5MlfUdXwaS3r5KB7jI4r0l0IBTjIaUgXcyRl
        SUM4IXUpw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSxpU-0004vC-5h; Fri, 08 Nov 2019 06:33:08 +0000
Date:   Thu, 7 Nov 2019 22:33:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-ID: <20191108063308.GB18778@infradead.org>
References: <20191107195355.80608-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107195355.80608-1-joel@joelfernandes.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> -		 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED
> -		 * read-only mapping, take care to not allow mprotect to revert
> -		 * protections.
> +		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
> +		 * MAP_SHARED and read-only, take care to not allow mprotect to
> +		 * revert protections on such mappings. Do this only for shared
> +		 * mappings. For private mappings, don't need to mask VM_MAYWRITE

This adds an > 80 char line.
