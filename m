Return-Path: <linux-kselftest+bounces-23990-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E337A0430F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462677A0632
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED691F0E2A;
	Tue,  7 Jan 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CMnk2QAv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D241F2370;
	Tue,  7 Jan 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261262; cv=none; b=YoVE2gSx2HhylkvRnx6kkVBPw0ibIcgi3r3k1o9DEUZQJj9OcE9O1z1jYyCgcsYl8fCJN2m2EkNtnLva/oJIQJsAkCBOhbCo/KA+0rSm2U5VREeLAnlQHRWfK18p2Nae+zfLd6qXaFbK9SFGcTybtdkyWgosoeM/snviu/bdyH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261262; c=relaxed/simple;
	bh=z9AcZKXBTCewxT8SPTS20nArEMQztrWlt8OFGIyL2io=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IYlnjIW7o4aNmRmVeS0JaJ5Uh6EujVNUGkJ9Ygn04NB2/390iCUiYARKA7P/Uu2Jr4DtsG6lOS4B4weDtUUMpIyfX1fam4kfZw+po38N7cBMuWVLAyLAirv5cMnVf0seWDibaH+POxuZL1YV35uRUrQWqkSJ/5bNbgqZ9am+f7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CMnk2QAv; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736261260; x=1767797260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kzqP3KWquCSCvitwLtozsomdOR3PJTWU3++JR+6rcS0=;
  b=CMnk2QAv+JNq4OBfRUrZVbBCfKqza9z7TrdKUxm27DJAaahnb4CdtgBL
   66LHR5midZDHrrm8oIXMyF5ikBKH2LApxfvYcOYC6+0zc4YJM0S4TKT2L
   lPtHkepVHwolN1flxAXBoyBkNqmTyN38Oge7fpqLBYh7BsASJ4Ce7KpB2
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,295,1728950400"; 
   d="scan'208";a="687495332"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 14:47:34 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:43223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.48:2525] with esmtp (Farcaster)
 id 9b48386a-8619-40f1-8b35-660ddef4cf53; Tue, 7 Jan 2025 14:47:33 +0000 (UTC)
X-Farcaster-Flow-ID: 9b48386a-8619-40f1-8b35-660ddef4cf53
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 7 Jan 2025 14:47:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.249.113) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 7 Jan 2025 14:47:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <andrew+netdev@lunn.ch>, <b.a.t.m.a.n@lists.open-mesh.org>,
	<bpf@vger.kernel.org>, <bridge@lists.linux.dev>, <davem@davemloft.net>,
	<donald.hunter@gmail.com>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <idosch@nvidia.com>, <jiri@resnulli.us>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-can@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-ppp@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<liuhangbin@gmail.com>, <netdev@vger.kernel.org>,
	<osmocom-net-gprs@lists.osmocom.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
Date: Tue, 7 Jan 2025 23:47:14 +0900
Message-ID: <20250107144714.74446-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com>
References: <CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Tue, 7 Jan 2025 20:53:19 +0800
> On Tue, Jan 7, 2025 at 4:57 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> [...]
> >
> > We can fix this by linking the dev to the socket's netns and
> > clean them up in __net_exit hook as done in bareudp and geneve.
> >
> > ---8<---
> > diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> > index 89a996ad8cd0..77638a815873 100644
> > --- a/drivers/net/gtp.c
> > +++ b/drivers/net/gtp.c
> > @@ -70,6 +70,7 @@ struct pdp_ctx {
> >  /* One instance of the GTP device. */
> >  struct gtp_dev {
> >         struct list_head        list;
> > +       struct list_head        sock_list;
> >
> >         struct sock             *sk0;
> >         struct sock             *sk1u;
> > @@ -102,6 +103,7 @@ static unsigned int gtp_net_id __read_mostly;
> >
> >  struct gtp_net {
> >         struct list_head gtp_dev_list;
> > +       struct list_head gtp_sock_list;
> 
> After a closer look at the GTP driver, I'm confused about
> the gtp_dev_list here. GTP device is linked to this list at
> creation time, but netns can be changed afterwards.
> The list is used in gtp_net_exit_batch_rtnl(), but to my
> understanding net devices can already be deleted in
> default_device_exit_batch() by default.
> And I wonder if the use in gtp_genl_dump_pdp() can be
> replaced by something like for_each_netdev_rcu().

Right, it should be, or we need to set netns_local.
Will include this diff in the fix series.

---8<---
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2460a2c13c32..f9186eda36f0 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2278,6 +2278,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
 	int i, j, bucket = cb->args[0], skip = cb->args[1];
 	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
 	struct pdp_ctx *pctx;
 	struct gtp_net *gn;
 
@@ -2287,7 +2288,10 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
+	for_each_netdev_rcu(net, dev) {
+		if (dev->rtnl_link_ops != &gtp_link_ops)
+			continue;
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
---8<---

Otherwise, we need to move it manually like this, which is
apparently overkill and unnecessary :p

---8<---
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 2460a2c13c32..90b410b73c89 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2501,6 +2501,46 @@ static struct pernet_operations gtp_net_ops = {
 	.size	= sizeof(struct gtp_net),
 };
 
+static int gtp_device_event(struct notifier_block *nb,
+			    unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct gtp_dev *gtp;
+	struct gtp_net *gn;
+
+	if (dev->rtnl_link_ops != &gtp_link_ops)
+		goto out;
+
+	gtp = netdev_priv(dev);
+
+	switch (event) {
+	case NETDEV_UNREGISTER:
+		if (dev->reg_state != NETREG_REGISTERED)
+			goto out;
+
+		/* dev_net(dev) is changed, see __dev_change_net_namespace().
+		 * rcu_barrier() after NETDEV_UNREGISTER guarantees that no
+		 * one traversing a list in the old netns jumps to another
+		 * list in the new netns.
+		 */
+		list_del_rcu(&gtp->list);
+		break;
+	case NETDEV_REGISTER:
+		if (gtp->list.prev != LIST_POISON2)
+			goto out;
+
+		/* complete netns change. */
+		gn = net_generic(dev_net(dev), gtp_net_id);
+		list_add_rcu(&gtp->list, &gn->gtp_dev_list);
+	}
+out:
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block gtp_notifier_block = {
+	.notifier_call = gtp_device_event,
+};
+
 static int __init gtp_init(void)
 {
 	int err;
@@ -2511,10 +2551,14 @@ static int __init gtp_init(void)
 	if (err < 0)
 		goto error_out;
 
-	err = rtnl_link_register(&gtp_link_ops);
+	err = register_netdevice_notifier(&gtp_notifier_block);
 	if (err < 0)
 		goto unreg_pernet_subsys;
 
+	err = rtnl_link_register(&gtp_link_ops);
+	if (err < 0)
+		goto unreg_netdev_notifier;
+
 	err = genl_register_family(&gtp_genl_family);
 	if (err < 0)
 		goto unreg_rtnl_link;
@@ -2525,6 +2569,8 @@ static int __init gtp_init(void)
 
 unreg_rtnl_link:
 	rtnl_link_unregister(&gtp_link_ops);
+unreg_netdev_notifier:
+	register_netdevice_notifier(&gtp_notifier_block);
 unreg_pernet_subsys:
 	unregister_pernet_subsys(&gtp_net_ops);
 error_out:
@@ -2537,6 +2583,7 @@ static void __exit gtp_fini(void)
 {
 	genl_unregister_family(&gtp_genl_family);
 	rtnl_link_unregister(&gtp_link_ops);
+	register_netdevice_notifier(&gtp_notifier_block);
 	unregister_pernet_subsys(&gtp_net_ops);
 
 	pr_info("GTP module unloaded\n");
---8<---

