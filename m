Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B79CA146BF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 15:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWOzc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 09:55:32 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40035 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbgAWOzb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 09:55:31 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F8BC220A5;
        Thu, 23 Jan 2020 09:55:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 23 Jan 2020 09:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yiC+383aQusgjPnJNQT4ED4fIT3
        lvoMY1j6VwGnrRq0=; b=QVHoeedqMJrlH9Nt6qwey6TcleOpDOe+7Al0zy4wMf/
        cHi9gMJpfPcqOGH0druivU2/A+DRHFYmBV5HzQoklQMvG6wr5H8qaJCvneUGBdtD
        l2QAGKZI7kjoJfM4Wkw9Wg11woMssiM76CFQnUw5lhCz3ZWA6HyBrW1QIlkvYbhw
        gFpLzmCWFO/PkKGonfMszy867rEiPBmtTYHvx8VH9sb6KhywFngBM4Ndp+MOp8Xa
        RFaoTbRE2JRmWIa0/7t1i6+bfDIgcSUXQT3s2aV57MStKEsFU3QT2Txk5y9O0faE
        ThmUOQxgADmo9dbBoPJrH/lWAF8fx7V38W+gMmdvNcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yiC+38
        3aQusgjPnJNQT4ED4fIT3lvoMY1j6VwGnrRq0=; b=rxR7+2lJTzhQ37v7m4B0DU
        4YnM5toUIapE/ksRMV0mWT/OB5g3fJYMoOC6/bYaP6GJ+sRV/nFCEStBzFHibK2k
        bsCMzgxYPGBXJqjvGRlurnh7D8E06D4Ckj6oTV6qkcKL0AaHpOYAjuO08VH6V65S
        nhTp0wVEuDG+2KBCOBHKfSwYRbMFgmGZawMmlR+uS20DeHzUAx4nCwVyoD3eBmo+
        QjwpoxhLSbbuxpEJlPlb1DoHfIlMXGyO9cDRhPcmyF8zH+QBqwlLezwsmW4Ydwqu
        OKWQXgx9G4QEB8wTzBm6kC24iJwWj8oSSfms23S26HFfhAwU42MdOhte+uWNlKkQ
        ==
X-ME-Sender: <xms:4bMpXmvJXP68kjggQA78ttZvw7lFdYXsZIRFLrwb0YX9yJZdCoFLXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledruddtje
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgv
    gheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:4bMpXgDGUDBtl7QBx5BPt9Cn0IqqtC16Bduq47jhCmzjqtyqcLGNZg>
    <xmx:4bMpXto-LyMa7Lx72tSV5L70BmpNMVzGtatyeojdAwl9SxB-ITem0g>
    <xmx:4bMpXt7OAUIK51bAStkIELQAGVkFEFEVQrAbP6iqnNSEKMUc00GWxw>
    <xmx:4rMpXmoRWnVMs5LG0Uvce0_y9WeouzcQbBrGVNRwORm9S0TKpBTSkQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1E843280064;
        Thu, 23 Jan 2020 09:55:29 -0500 (EST)
Date:   Thu, 23 Jan 2020 15:55:26 +0100
From:   Greg KH <greg@kroah.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     brendanhiggins@google.com, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kunit 1/3] kunit: add debugfs
 /sys/kernel/debug/kunit/<suite>/results display
Message-ID: <20200123145526.GB1687563@kroah.com>
References: <1579790840-27009-1-git-send-email-alan.maguire@oracle.com>
 <1579790840-27009-2-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579790840-27009-2-git-send-email-alan.maguire@oracle.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 23, 2020 at 02:47:18PM +0000, Alan Maguire wrote:
> +int debugfs_init(void)
> +{
> +	if (!debugfs_rootdir)
> +		debugfs_rootdir = debugfs_create_dir(KUNIT_DEBUGFS_ROOT, NULL);
> +	if (IS_ERR(debugfs_rootdir))
> +		return PTR_ERR(debugfs_rootdir);
> +	return 0;

No, you never care if a debugfs call works or not, just call it and move
on.  So just create the directory, and then pass it into whatever
debugfs call you want, never test it or do anything about it.  This
function can be void as well.

> +void debugfs_create_suite(struct kunit_suite *suite)
> +{
> +	/* First add /sys/kernel/debug/kunit/<testsuite> */
> +	suite->debugfs = debugfs_create_dir(suite->name, debugfs_rootdir);
> +	if (IS_ERR(suite->debugfs))
> +		return;

Same here, don't test, just call and move on.

thanks,

greg k-h
