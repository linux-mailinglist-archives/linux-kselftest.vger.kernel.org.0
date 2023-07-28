Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C15767469
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjG1SVZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 14:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjG1SVY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 14:21:24 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012009.outbound.protection.outlook.com [40.93.200.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29524231;
        Fri, 28 Jul 2023 11:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XohoCRtL+38tQk9AYkVGqYnjM8JNCACf2SgVf5VF2+7UedQAMOjmoo+r45l8QlWdfZ/owOxcDT16RTrQr68F86iAuK5iNQX5naNle/MljQEcpe54XVGgZXtAlOjhymMdrjkA6o1uTsHrbBWF3CpvblE/kQcpSSjgtRHe3yC0FffhgeHzAUPR9TsLleC9lsvzHKvNGkM0i87LHzVBMsptdnWf7nSpSy2eSKoJqXgtpd82GhTn56En1/xyV11ipijpHR0TeDQsQwfQsI7Dzh8X1H/YNxrHOYfqGcOemwQOZHu10F6S+WnkAyG9ombUZVTDCjedtzvPlOO5OtfTV7arvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAWB6Lwkx0Qz1vK54TInJoGKBquAr68J0ferQze2GIg=;
 b=myngfAiV4Rc4pZj5bOXpQ90ysBXdl5dKMe4csuOi0MSSCozW98H/9cPDVMJjNTN53NZG/dDPpbjzpeJ+w12by39a4Y4wrJ6Sz+3HFEt+y1h6knlrTVK5p8BZPBq8jljZVz4QgACw4Twhwi5oqGs4qHtozeNyuY707QmE/neCtjpky7e9fU60AVr85kNdKxVo9CIjIxKkcWQmhe9RRJPNKyVXeBigZURIOrqlASAwfOX8wMaLgQ/Vmw8SWEuDGXNVM37sbkYq0q+ZB/+Q3Ry2jRR2rXqjpiZO+Ud/TQhzD2qxcZJc8rHCc0uiEGdrvdKRK2U/yGGK7qXtIrGgouGAwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAWB6Lwkx0Qz1vK54TInJoGKBquAr68J0ferQze2GIg=;
 b=VRboNx8nvygBo/ikerGJmsF2jVc0TmfhvyglFrThNsOVtcUqW6DeggKNGNAzn6rqjesuYH9HOEZW8S5p4kapFx/KeZiBDRAMA9PIAi14RGJUdiG7q6fpo3RPNcG8dGwAhKdYwXLm7qxjJf8F23hFunWhyS/zQlWIXgrPBrTiL70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SN7PR05MB9264.namprd05.prod.outlook.com (2603:10b6:806:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:21:20 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:21:20 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v6 03/10] tracefs: Rename and export some tracefs functions
Date:   Fri, 28 Jul 2023 23:50:45 +0530
Message-Id: <1690568452-46553-4-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690568452-46553-1-git-send-email-akaher@vmware.com>
References: <1690568452-46553-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0090.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::31) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SN7PR05MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 82286a59-4c0e-4bff-79ba-08db8f9770c9
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RedBd62VR+SJxG0p9MGsOgQHh9s3oCA4fhnIldkIWIh37NmpT565U759h1/WW/v3MS8zBdt0RXPk4IBxrWR+/5bh71u4h+FaXL5VBA51Llv5ANn72y3N3aDM6bkYUDPusm6eQ1wr4+rj4yEWdbYwu5k+3345PWNuEXDv65+2qowH0Yh7qH5974B/W9BgDeT7bZT2/NdjYfvMt5bm3UPt9KSd46r0yx9DvCMRWYmIQG02afgeC815KFBE2sp4CvkWrsR2fkxETufw/F94VebkeerZS1qByunO6ruZn/OcPhr5jwtdr/eW7N0faJdJl7lKCdayFrMJAoBAH1YD5e2izJE1wfZouQ+bDLQcsoUF2+XStoJHDve7Osnl/c5hDbzlqhuDts7ylnG4yL71cYyE3AefFC5+CRH7R5OZx60WxYUIwcN6nh6PpwyxF1FkaWbWIBPAyyrEMwzJeBFtVMJH6cDUlXOTuP6qlIVLgiWNoKsSO6mrUXpcloLkLiaMxsSqtp6D0bHhWXRiRkTLDd8SFfMrm7+TPQ6WIPQI8oqKPt5ifWmQVrG17n6llv5M8Owj/Dl5wngmqOUn/nc0HgzkE7j3LzV1fzfDHCjhnDDy11OxTM56Po3n/0dzulEqrxIoooVVjiETKqdds9aV0dER0V7VIhnFzMVq+2x80VZmdes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199021)(2906002)(316002)(7416002)(8676002)(86362001)(8936002)(41300700001)(36756003)(6512007)(5660300002)(107886003)(26005)(6506007)(6666004)(6486002)(52116002)(83380400001)(478600001)(38350700002)(186003)(38100700002)(4326008)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4d/5YTV4imQ3tM8e5uFvAvnovgBivvo7RzwCZpL991dzYO0xgZTZlU7DhZOL?=
 =?us-ascii?Q?+8r8JOP48ohkpRttTZRpxOmNkPRR8jF+L3T8B9gWXjZ0HPxFJ3ZUQwoc1UX4?=
 =?us-ascii?Q?N7wcURH/uB0Tp00rC4aWVI25oRZqIfyrCrOlhBPyArs6AuSHBgtMPFNZQgiH?=
 =?us-ascii?Q?hPRTgzH5vCaq4YSXLLv2zkopUDjNlxr6KgxhEPsfX6QccLDmFxIPIDEZXCSk?=
 =?us-ascii?Q?Pza5e0b3ccUURbujf1Naj4PoWdCIk3bLExkA3Zg7f/w/z8BoxWC0uCl3XoTQ?=
 =?us-ascii?Q?1JxME+v3jMLsy3kWt2iAZQcKEFTulb81gXC8LPPiIg1oVaG7m1E63Y2ZP3AZ?=
 =?us-ascii?Q?SiOYv4IAq6VOb9stY6ZYFD1YT6zFaa4l4XdJgrNYmK1tZh1ZGc/ON9PHG9qI?=
 =?us-ascii?Q?//bqxQHP7yOuQXkHaS4QYlk3ar8gRiky2h54HH/fgjC1Tbd5m/CJtfBCagg8?=
 =?us-ascii?Q?VsxA0HsR6Z+qAFUxLvnwOQttItsSnolUx3oEBg11vUMyrqCAA3T8W0H92shj?=
 =?us-ascii?Q?auBoVi+FksNX91uSSyhFjzQeuVgrWnU7g3c/1DxLZ5h6zGIOchSy1EkLJ0+3?=
 =?us-ascii?Q?xpNdWih8raxO8kBfZUglV6tnPP/P7gVDcN0l+vmZ1rO6UBDxu2aeG5cCoXAA?=
 =?us-ascii?Q?wDqEO8MrtzW9dpdBitGQZoKpaM9eW84Y/oftUeUIyqSSArJmDWiEvcLTy0Jd?=
 =?us-ascii?Q?+ps0vH/Z1hJS/cPW4h7LJuJnLW3PJwACG0U03zy+MK0L8C/qyINsWfm4j1Re?=
 =?us-ascii?Q?6QxSgAaqNIBpdMHUBTn5St7LqtA1AnFQFD9f606cCGNR2QITJVcf9YwCx/TP?=
 =?us-ascii?Q?Q42J84xdUld0mK0DV8mOnXlSecqPoiySvVIhBCQ5LhJpfYmLzPVNwL2gn01s?=
 =?us-ascii?Q?S7yEC/+DfCjd7WEyZQG1U5Pssf9dRWKM487YBZgw8Xqc2oK6MVv6D8hSy8zl?=
 =?us-ascii?Q?ZhUcsIPKsJ63OFnQqReIJ8RFGPppvIEBC8EApWxx4lzEnw0Op1VNzi9kZLOV?=
 =?us-ascii?Q?LcTF/zyxAiOG8C5sqPq7EbFkAUJMtew2RTqRHWycaa2nlIajOE9lPVL02rtv?=
 =?us-ascii?Q?47vFkRgaqh0hrVA+P4kP1Hi7z0fqtcBep9i7vOo6NVXWiml6j+noTVzRFlLb?=
 =?us-ascii?Q?5C9v4dyP5GNapE8CBsNBJrTtynVRwoKXL64sPaA/zScxTyT+LOPN0/091JOt?=
 =?us-ascii?Q?frCBLZsRDx1spgTU/mmYg+xiXofUsOb3i/D4799g5t39S8/EVPiTmghPo0wW?=
 =?us-ascii?Q?xmjN3WsKTTPVz2WsXyVB57OU7Qj/9sBmRHZpBOqSO4dK2KiWEFS7FmKMiqEZ?=
 =?us-ascii?Q?/Vf7ZCbJSCGyLiC+sirpzKHf+VKFDjlbx3hvMvw5Rmb/BH96r33HI4n5GRUp?=
 =?us-ascii?Q?uioP4/fWv5cJX/y42fk6wFsMv0SD2FtkniqXS6hJzWwCnROZFk8XiXWTQjEI?=
 =?us-ascii?Q?4VAdv7hGxltO9L38k+StAUcr2JZslX5wg4UNC9PMo9z1MjEmLlekBqiXWGOi?=
 =?us-ascii?Q?XWwf6UdJaxBU2yCKPHAsJ+qeWH4dQKehBuPKthGGKJ1M8TTApn6WRhZVlpUo?=
 =?us-ascii?Q?Rmh0Rd2WtXxcvbCEqsCubjh30HFrpKD20NDZeLIV?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82286a59-4c0e-4bff-79ba-08db8f9770c9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:21:19.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEhTwqO2248S3GWGXaWmMqIj4Ie2bovLz2k2iz9sCc8W9WU9nkn7dcxYtXWYa1w82rr+C6tZCZudcpkawJ9WXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB9264
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Export a few tracefs functions that will be needed by the eventfs dynamic
file system. Rename them to start with "tracefs_" to keep with the name
space.

start_creating -> tracefs_start_creating
failed_creating -> tracefs_failed_creating
end_creating -> tracefs_end_creating

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c    | 20 ++++++++++----------
 fs/tracefs/internal.h |  5 +++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 2508944cc4d8..4acc4b4dfd22 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -147,7 +147,7 @@ static const struct inode_operations tracefs_dir_inode_operations = {
 	.rmdir		= tracefs_syscall_rmdir,
 };
 
-static struct inode *tracefs_get_inode(struct super_block *sb)
+struct inode *tracefs_get_inode(struct super_block *sb)
 {
 	struct inode *inode = new_inode(sb);
 	if (inode) {
@@ -422,7 +422,7 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
+struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -460,7 +460,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
@@ -468,7 +468,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	return NULL;
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
@@ -513,14 +513,14 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	if (!(mode & S_IFMT))
 		mode |= S_IFREG;
 	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
+	dentry = tracefs_start_creating(name, parent);
 
 	if (IS_ERR(dentry))
 		return NULL;
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return failed_creating(dentry);
+		return tracefs_failed_creating(dentry);
 
 	inode->i_mode = mode;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
@@ -529,13 +529,13 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 	inode->i_gid = d_inode(dentry->d_parent)->i_gid;
 	d_instantiate(dentry, inode);
 	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return tracefs_end_creating(dentry);
 }
 
 static struct dentry *__create_dir(const char *name, struct dentry *parent,
 				   const struct inode_operations *ops)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry = tracefs_start_creating(name, parent);
 	struct inode *inode;
 
 	if (IS_ERR(dentry))
@@ -543,7 +543,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return failed_creating(dentry);
+		return tracefs_failed_creating(dentry);
 
 	/* Do not set bits for OTH */
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
@@ -557,7 +557,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return tracefs_end_creating(dentry);
 }
 
 /**
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 954ea005632b..7dfb7ebc1c3f 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -12,4 +12,9 @@ static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
 {
 	return container_of(inode, struct tracefs_inode, vfs_inode);
 }
+
+struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
+struct dentry *tracefs_end_creating(struct dentry *dentry);
+struct dentry *tracefs_failed_creating(struct dentry *dentry);
+struct inode *tracefs_get_inode(struct super_block *sb);
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.39.0

