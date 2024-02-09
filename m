Return-Path: <linux-kselftest+bounces-4392-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B3584F28D
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 10:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1805F28A397
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 09:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC667C5D;
	Fri,  9 Feb 2024 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0WgNSwh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A93FDF;
	Fri,  9 Feb 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472099; cv=none; b=c8XynZlMQLHMAEs21yCc/UT8RG7qrMomUv4EhqquC6nr+Qs33wn+2n12J9HtPwjtwPEVqIfOJsDOKkdDR63GmV1vjq5YcGD+BBlSTZudWvSv0JkacVT+XOMWIx7TJzvAa8cBkVrf4cXC3dAKdEhRRpkUERtoKhX24CtRY45Hdo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472099; c=relaxed/simple;
	bh=gsxnPlmgw7aelaFq29J9POC9VzbhNurN7rpiXS1bR+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXzk2OZB2ELEQTgQOtbl+f+dpsUYw5UzsbSApqCnms+6UbsXyOCt7Yg7qNL6e26qB7tfcLlW4fyUx1AbKp6VdGoeUgC6i72OZmQ1RnM/WH4CGaV39A1kmSfesgw6Gp7xvatv0x378U+k6hRQJSgFgnOAMw6gXAG1aM1i/nOMVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0WgNSwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F1EC433C7;
	Fri,  9 Feb 2024 09:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472099;
	bh=gsxnPlmgw7aelaFq29J9POC9VzbhNurN7rpiXS1bR+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0WgNSwhwA/cjC2gOedNvSEloY/TE3CyzwK/GAg+9shiD/7+dsyhOASzbw+ooDnWV
	 lZxS8i3nkskFTvcqx7FXbZ9tdMx6XhpFowgKe5FlkCwk9vkPxeNMdmpCpnNtqPWt6L
	 82sC0xmSR8TTSnRqsIa4QwAKJLwc5lPNz3lsnFcFG5l3AXt8/X10/SM9JA7N9pUS1H
	 Rgjggnn6/R60TjxjLLQXNisVPXKxapSEX6GvIXKj5tEPJBvvrP2yuBtMYUU/vyCQS3
	 ONv3X62etNteBGPUQc9WYHVO1nhxQTHztMndHxT3Gdtzj/AKDBJURTFEt4hATUMgI1
	 zH0w9WPJHENJQ==
Date: Fri, 9 Feb 2024 10:48:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, chuck.lever@oracle.com, jlayton@kernel.org, 
	neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 22/25] evm: Move to LSM infrastructure
Message-ID: <20240209-weinreben-geheilt-b9fcf9839575@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-23-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-23-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:18:06PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> As for IMA, move hardcoded EVM function calls from various places in the
> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
> (last and always enabled like 'ima'). The order in the Makefile ensures
> that 'evm' hooks are executed after 'ima' ones.
> 
> Make EVM functions as static (except for evm_inode_init_security(), which
> is exported), and register them as hook implementations in init_evm_lsm().
> Also move the inline functions evm_inode_remove_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_set_acl() from the public
> evm.h header to evm_main.c.
> 
> Unlike before (see commit to move IMA to the LSM infrastructure),
> evm_inode_post_setattr(), evm_inode_post_set_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
> executed for private inodes.
> 
> Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/attr.c                                     |   2 -
>  fs/posix_acl.c                                |   3 -
>  fs/xattr.c                                    |   2 -

Acked-by: Christian Brauner <brauner@kernel.org>

