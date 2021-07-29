Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3F53D9D4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 07:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhG2Fza (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 01:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233899AbhG2Fza (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 01:55:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0051061053;
        Thu, 29 Jul 2021 05:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627538127;
        bh=ObnkQ2ekSkknguegUJ7oExEOcolBoewZBGjOauRDd3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lh1TFgzO8hSkhAVPKwCAi4BlEo6JyDRjaF3INXNV0sbrenyNlfF+oMRuMyYpj0CDK
         EKWd9LZ0ZdyQCX1WVCkf6SH0fQiZcWiAK4y9OemniNcWgeLYVRnKEuZesGhXuG0BN5
         ZLB83ZvZJ8r5mqWp18L9iihqVZCNghZMGDKDbaqE=
Date:   Thu, 29 Jul 2021 07:55:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>
Subject: Re: [PATCH v2 2/3] kunit: Add support for suite initialization and
 cleanup
Message-ID: <YQJCyigNroTl8J/l@kroah.com>
References: <20210729044125.7435-1-bvanassche@acm.org>
 <20210729044125.7435-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729044125.7435-3-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 09:41:24PM -0700, Bart Van Assche wrote:
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: kunit-dev@googlegroups.com
> Cc: linux-kselftest@vger.kernel.org
> Cc: Bodo Stroesser <bostroesser@gmail.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Yanko Kaneti <yaneti@declera.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---

I know I do not take patches without any changelog text.  Maybe other
maintainers are more lax :(

