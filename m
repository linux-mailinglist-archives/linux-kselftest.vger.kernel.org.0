Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF18454B54
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Nov 2021 17:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhKQQwI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 11:52:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:32892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239260AbhKQQvy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 11:51:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD8661360;
        Wed, 17 Nov 2021 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637167735;
        bh=8sDlGbeAeXlFYtUmwsi6Q/cW6sg9DnvV8KfzR8I1JaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EyWsMmnWC8EWl02dqwlEPy9xDkhtTK9VXmTzeV4oacRzUIypG/bQAnTBFWz2NZ6wh
         /dkerR9m4424BmSfrkLZXdKXQCUfQRQ6Fz6wcE9mnBUb58TqrHGaNNxvEuB7Si85Lh
         7X4Uep6U4X24ZfbqN1BoRXjKvmnu4/e1+tQ88DuCQ1qI+gqIgovhkaWpvAZRVSIwOj
         S4g7+Bcbaxjt+h1+u//3JFs5XJISOUYejGmQLfJmK+4PQp0wJ77tETSMV1JZ749bSt
         p7CRyNnZsjLoxiU+DroVwLfOm5Di8IgycR0Xj9QMkZj1CBQiP7YaXKvxqV8rHhNLlK
         810u/s/5jFqdA==
Date:   Wed, 17 Nov 2021 08:48:54 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Davide Caratti <dcaratti@redhat.com>,
        Li Zhijian <zhijianx.li@intel.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, lizhijian@cn.fujitsu.com,
        linux-kernel@vger.kernel.org, lkp@intel.com, philip.li@intel.com
Subject: Re: [PATCH v2 1/3] selftests/tc-testing: add exit code
Message-ID: <20211117084854.0d44d64b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <4ed23cd5-f4a1-aa70-183f-fbea407c19ee@mojatatu.com>
References: <20211117054517.31847-1-zhijianx.li@intel.com>
        <YZTDcjv4ZPXv8Oaz@dcaratti.users.ipa.redhat.com>
        <20211117060535.1d47295a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <4ed23cd5-f4a1-aa70-183f-fbea407c19ee@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 17 Nov 2021 11:41:18 -0500 Jamal Hadi Salim wrote:
> Did you mean adding a maintainer for tdc or just generally point
> who/what to involve when making changes? Typically the mailing list
> should be sufficient. Outside the list, at the moment, any outstanding
> issues on tdc are discussed/resolved in the monthly TC meetups (where
> all the stake holders show up)...

I'm mostly interested in the code review and merging part.

Would be great to have a MAINTAINERS entry with a set of folks
who can review patches, so that get_maintainers.pl can do its job.

At the very least to make sure netdev is CCed.
