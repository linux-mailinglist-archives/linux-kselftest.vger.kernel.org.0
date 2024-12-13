Return-Path: <linux-kselftest+bounces-23299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C969F0558
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 08:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D56168CD4
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 07:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709BC18C018;
	Fri, 13 Dec 2024 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSjJDH78"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82E1552FC;
	Fri, 13 Dec 2024 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074302; cv=none; b=NgibJfk506vxiXB+vj+YHc0h7ayiLIscAvn2Hopt9+ribxuE2dEp8xTiLhZQqYry/hUHpAAi+934Q3JhmQ6rrvwSSEdm9u3+AWYIDSHE3u622Xx3Dl6fttzUq8BX/ttD6RGkaU2k7cs3oIqfgl+DyCOEVoAqMBwh1SNSHUw3DzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074302; c=relaxed/simple;
	bh=JUTjC5vX1dVdVtJWRwBrLA9SUDNWUOVFEGRoDkq3eMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+AEVue+hFnthy9fLqkbKeMnRXgHkKY//E0TAoe3kIKyPZfsLsCaS7DqUo9t2mZAxmzAFMl6QAiVNBm3uP0VPoodlek8ysYZp0Ss28tiBNnXmoUO1J3FLA1QN0b3Eb0n3TrObRZ1XvKVYWyEq0XUmucrxveYyzR7W/2glfx8KMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSjJDH78; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728f1e66418so1273131b3a.2;
        Thu, 12 Dec 2024 23:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734074298; x=1734679098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfvD/8PI0WXSrCtYG4Xt9DWTdGFSjZV64vqg60IXsD4=;
        b=RSjJDH78vqd86GG8oMpS0VDlf0Phfeu3gLCB/gvSh+OwHDcbhVrHaDfMO2PVW7Tgpp
         NnJLlRZKlYBxqfGNihY10B++OANzzoRf7cNAjhj8P4QoSVfeOfRrmRegPVr2LS1ZpD2Z
         LDg9R+Zp0w76pwp4eHjAkw3nqVVzSq0zyU+vzSukyJy+aHlfxdtntFXIxXHKfcuKvJXi
         nTJP8pJ3DDOxgqRr49YFI1dXRru3tZdxUg/7JmDK/xGUjGER7ccQHP5VXdh2DdevEkIR
         n4W/UxyDZcK5sS6nSlS2HXROl016v0d1H+iSTEYTj0MU8WBIKK/NinV/X8/apo81Jrgj
         JB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734074298; x=1734679098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfvD/8PI0WXSrCtYG4Xt9DWTdGFSjZV64vqg60IXsD4=;
        b=Og+ys8Uz+ZpWRFVmMwD1VYO2VVDJcgo6sdNvAh5BUeCYy1pHjYr26whkwG1fEhF3+0
         WbGe0tOiE6XnQmArKFYozpsbT25uI0weQBLK0FkClAC1H68254pDgYj5b9avP40wwMUV
         QA16i4v7CsNfE1dQaq/FyiVQDrURw3zPRerrxmTBlf/EAagHhq0MlyZvh78au3Xi6fP1
         p553bsrpkaFraIh1hAHXgD0C0jwE/gc4x846tIcXRvMIjFqQX5yd8h0KtUxnRex/9w4g
         UAZGmfEyNyuUo54es88thuGmyVcGqdsgdtxHgcqCzvM5iiUYnEa1McZP0FNkjH9OeV13
         dOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTjaZsu7W+wxJaVu5ZEXGT2esmaPr58AI1pm85iQLx9Esf+ArxISyIfmfSeBtLH1+Gzrx2azYLMNgl+fc=@vger.kernel.org, AJvYcCUt37ZFC+pC4h+rCK2nIOaY8sLibYkfUH0Qhi+MmUj1XnXEZLvJVgWhaqV0Z3ruvX1RIzAqw0irBZpRd6Ykih5i@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgu+r69movASQXm2gOKmaUle/m5tl/u3xoxI+aP4s6J/4dh/1
	Te7daG0FxzgDjXhfOrtwcQVUR1F1+shfJV5MiyLGv5IYnRqAtoQf
X-Gm-Gg: ASbGncsuYOBYRKHUHehUAspPfpBnwuy40B9SQxM88lOQnvspunpopCpMZGpuP1n54jb
	aoIvn/lfOEGlsHzcpSZ0FG6X9ES9nIGTIwVHtMguJJTF52BRw8fpyvFdh/CWe9kI8Ue0ZYlJswk
	Ml0mHSBy2+UCWlh9oECHTiPGvMke+9H8+8Two8oaY9QmstDl8trjDX7uskJvM6TWbm+2ATaGjdv
	Sc/ZO+FvAqQVjecu8siFwCU9salIQ4esF+55KoJE2qYByb4j3iZhrRVFvLX1A==
X-Google-Smtp-Source: AGHT+IFL1q55TlEnnrqbzlDlt1VEt1MreABcTpf3y40zMVE5wp4aBpLQ1mhBBtjg5de7EkdLLBv2RQ==
X-Received: by 2002:a05:6a20:9f04:b0:1e0:dc06:4f4d with SMTP id adf61e73a8af0-1e1dfd70716mr2598345637.19.1734074297996;
        Thu, 12 Dec 2024 23:18:17 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd430cec7bsm9055336a12.67.2024.12.12.23.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 23:18:17 -0800 (PST)
Date: Fri, 13 Dec 2024 07:18:08 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/2] bond: fix xfrm offload feature during init
Message-ID: <Z1vfsAyuxcohT7th@fedora>
References: <20241211071127.38452-1-liuhangbin@gmail.com>
 <20241212062734.182a0164@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212062734.182a0164@kernel.org>

On Thu, Dec 12, 2024 at 06:27:34AM -0800, Jakub Kicinski wrote:
> On Wed, 11 Dec 2024 07:11:25 +0000 Hangbin Liu wrote:
> > The first patch fixes the xfrm offload feature during setup active-backup
> > mode. The second patch add a ipsec offload testing.
> 
> Looks like the test is too good, is there a fix pending somewhere for
> the BUG below? We can't merge the test before that:

This should be a regression of 2aeeef906d5a ("bonding: change ipsec_lock from
spin lock to mutex"). As in xfrm_state_delete we called spin_lock_bh(&x->lock)
for the xfrm state delete.

But I'm not sure if it's proper to release the spin lock in bond code.
This seems too specific.

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7daeab67e7b5..69563bc958ca 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -592,6 +592,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
 out:
 	netdev_put(real_dev, &tracker);
+	spin_unlock_bh(&xs->lock);
 	mutex_lock(&bond->ipsec_lock);
 	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
 		if (ipsec->xs == xs) {
@@ -601,6 +602,7 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
 		}
 	}
 	mutex_unlock(&bond->ipsec_lock);
+	spin_lock_bh(&xs->lock);
 }
 

What do you think?

Thanks
Hangbin
> 
> https://netdev-3.bots.linux.dev/vmksft-bonding-dbg/results/900082/11-bond-ipsec-offload-sh/stderr
> 
> [  859.672652][    C3] bond_xfrm_update_stats: eth0 doesn't support xdo_dev_state_update_stats
> [  860.467189][ T8677] bond0: (slave eth0): link status definitely down, disabling slave
> [  860.467664][ T8677] bond0: (slave eth1): making interface the new active one
> [  860.831042][ T9677] bond_xfrm_update_stats: eth1 doesn't support xdo_dev_state_update_stats
> [  862.195271][ T9683] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:562
> [  862.195880][ T9683] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9683, name: ip
> [  862.196189][ T9683] preempt_count: 201, expected: 0
> [  862.196396][ T9683] RCU nest depth: 0, expected: 0
> [  862.196591][ T9683] 2 locks held by ip/9683:
> [  862.196818][ T9683]  #0: ffff88800a829558 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{4:4}, at: xfrm_netlink_rcv+0x65/0x90 [xfrm_user]
> [  862.197264][ T9683]  #1: ffff88800f460548 (&x->lock){+.-.}-{3:3}, at: xfrm_state_flush+0x1b3/0x3a0
> [  862.197629][ T9683] CPU: 3 UID: 0 PID: 9683 Comm: ip Not tainted 6.13.0-rc1-virtme #1
> [  862.197967][ T9683] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [  862.198204][ T9683] Call Trace:
> [  862.198352][ T9683]  <TASK>
> [  862.198458][ T9683]  dump_stack_lvl+0xb0/0xd0
> [  862.198659][ T9683]  __might_resched+0x2f8/0x530
> [  862.198852][ T9683]  ? kfree+0x2d/0x330
> [  862.199005][ T9683]  __mutex_lock+0xd9/0xbc0
> [  862.199202][ T9683]  ? ref_tracker_free+0x35e/0x910
> [  862.199401][ T9683]  ? bond_ipsec_del_sa+0x2c1/0x790
> [  862.199937][ T9683]  ? find_held_lock+0x2c/0x110
> [  862.200133][ T9683]  ? __pfx___mutex_lock+0x10/0x10
> [  862.200329][ T9683]  ? bond_ipsec_del_sa+0x280/0x790
> [  862.200519][ T9683]  ? xfrm_dev_state_delete+0x97/0x170
> [  862.200711][ T9683]  ? __xfrm_state_delete+0x681/0x8e0
> [  862.200907][ T9683]  ? xfrm_user_rcv_msg+0x4f8/0x920 [xfrm_user]
> [  862.201151][ T9683]  ? netlink_rcv_skb+0x130/0x360
> [  862.201347][ T9683]  ? xfrm_netlink_rcv+0x74/0x90 [xfrm_user]
> [  862.201587][ T9683]  ? netlink_unicast+0x44b/0x710
> [  862.201780][ T9683]  ? netlink_sendmsg+0x723/0xbe0
> [  862.201973][ T9683]  ? ____sys_sendmsg+0x7ac/0xa10
> [  862.202164][ T9683]  ? ___sys_sendmsg+0xee/0x170
> [  862.202355][ T9683]  ? __sys_sendmsg+0x109/0x1a0
> [  862.202546][ T9683]  ? do_syscall_64+0xc1/0x1d0
> [  862.202738][ T9683]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  862.202986][ T9683]  ? __pfx_nsim_ipsec_del_sa+0x10/0x10 [netdevsim]
> [  862.203251][ T9683]  ? bond_ipsec_del_sa+0x2c1/0x790
> [  862.203457][ T9683]  bond_ipsec_del_sa+0x2c1/0x790
> [  862.203648][ T9683]  ? __pfx_lock_acquire.part.0+0x10/0x10
> [  862.203845][ T9683]  ? __pfx_bond_ipsec_del_sa+0x10/0x10
> [  862.204034][ T9683]  ? do_raw_spin_lock+0x131/0x270
> [  862.204225][ T9683]  ? __pfx_do_raw_spin_lock+0x10/0x10
> [  862.204468][ T9683]  xfrm_dev_state_delete+0x97/0x170
> [  862.204665][ T9683]  __xfrm_state_delete+0x681/0x8e0
> [  862.204858][ T9683]  xfrm_state_flush+0x1bb/0x3a0
> [  862.205057][ T9683]  xfrm_flush_sa+0xf0/0x270 [xfrm_user]
> [  862.205290][ T9683]  ? __pfx_xfrm_flush_sa+0x10/0x10 [xfrm_user]
> [  862.205537][ T9683]  ? __nla_validate_parse+0x48/0x3d0
> [  862.205744][ T9683]  xfrm_user_rcv_msg+0x4f8/0x920 [xfrm_user]
> [  862.205985][ T9683]  ? __pfx___lock_release+0x10/0x10
> [  862.206174][ T9683]  ? __pfx_xfrm_user_rcv_msg+0x10/0x10 [xfrm_user]
> [  862.206412][ T9683]  ? __pfx_validate_chain+0x10/0x10
> [  862.206614][ T9683]  ? hlock_class+0x4e/0x130
> [  862.206807][ T9683]  ? mark_lock+0x38/0x3e0
> [  862.206986][ T9683]  ? __mutex_trylock_common+0xfa/0x260
> [  862.207181][ T9683]  ? __pfx___mutex_trylock_common+0x10/0x10
> [  862.207425][ T9683]  netlink_rcv_skb+0x130/0x360

