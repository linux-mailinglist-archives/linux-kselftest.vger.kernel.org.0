Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E546F42B5
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjEBLZQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjEBLYt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:24:49 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013011.outbound.protection.outlook.com [52.101.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040B1558B;
        Tue,  2 May 2023 04:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNoQEm3RKfrh9RSSrIhgUKZ25URb74WvBhLXBSFJQoSy7kBvEWLGC3ZtupnbKxp6fPqLfCv8/A6kPB5DgrlSscu6GIsNg2iU8lSb9QBnZIbZ8zXri8af6ARF/5ISBdAkS+iUtaB5U6bgK55Y/tB0XTuoHZdca6Z92PonunTGCCFfnloiU53fyttBjcTkFZv1zFTiVwf3IVhLCchyQ3gaS3Go1/ISPHP1dWagkuvEs9HcBsZvn4CS2VA/cU38gLgq9HgpWqObCke8p19uOKlfXdlkTN3yOQr3nk4fX9bVYgLk5iK/+cvhelZEeZcKyZkH0okcvn3WJF0ZO7GrXEcJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2ct1Q7hesDl4mZGK7qLPhrph4joBS9Y2AklBElPvBc=;
 b=LumKODwxaiiH3ktjXFZwQVEwklTwYhYClROhRlTZQMg5uxy37azq6zPnPEUJ/cjEnAP/cQnSIL3MTt57rGzZmShMHjnKx8bYbT81MCR9sUhZOfAsVaefesbm63M+JRTW/DmSjGAliZR0SIFeR7SJ+JHHSTRrY2Km+P6BRTtIsRfdoVifQgYKjUSrK+326/RwfeCTqdgVFHW+k+P+PjPA3Ugh97Ez+SBmu7GDYjmE7/8iUAtSbXdBGgOXkR074pVziaJA4852mzkRmEcBEMyvU3MkzxhIj4MpceE271fepw71s4WH+aAh9nM+zQHn612VKIjF2UIx4Byj6uR27JGO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2ct1Q7hesDl4mZGK7qLPhrph4joBS9Y2AklBElPvBc=;
 b=u+lZp4PLS2SdxR/9/5LpSEW+c2+IbADsYbkcaEpPsKANIOis2ufl+i6U5LnBDe1kmkMa5LsGwTKNZgv49VDB5vIXzmu30yGOwobjOd0rjQ6rozQkI+LNjsoTWDBcdbhJ162O28/63ZCTkc92Nw5vhNx2zIx91j4sJTPhadAZEus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:21 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:21 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 6/9] eventfs: adding eventfs lookup, read, open functions
Date:   Tue,  2 May 2023 16:53:17 +0530
Message-Id: <1683026600-13485-7-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1683026600-13485-1-git-send-email-akaher@vmware.com>
References: <1683026600-13485-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|BYAPR05MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb7a781-b404-4597-e14a-08db4affc69e
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djkVQmksS74IpI1N80kjWLqsghZ18trtsbazlo5w59mjvFSdCh50IuCe9c1f804wYaHM0aPOP1HiheAZTji0AdMh2FSJqkvdn6tR02YdGDnxnaNPGS5KMi3Zzzhy8U1dkYqmVuw3PV75Tr3nZgPSesXxbU3vPKDCWiB8pDbmgdOnP+aQ9WPQQD5mMFW2IHKTVX40GTMCYqDfq77zBWnrP1js34XNkmH9MJznLTrWvF0+m0gAi/p4vxbxXrzoyIYi2g9S4XaHgKfzoEy0gtxtG2AzV38jp7jIMW8ZXDT8a/Iwv836pprssr5ojLq+yyGRnK/sapOxCwRIo5aQNRc9JktytiPzTtUB8AP+TGGGi5294kg3B38m9wjj1aDPqlfQlegOb3oL3Zc/mObLCzQuzg7PU0bpHOqGOBPemR8AKu528q8OMCd/evO7vQKqhWaEjE6h/ZPcMMn2VonepcrT40OjCBHaTI1sYyNUAmg7cRI5XI5zw8L5itDk/yguoULzU0C1YqoEUrmOu/ZpeiORyBzg9FV43xNarWaO7OVgfvrqx9qOya2zvouZbCfqyHWoeiYzMMUNilmya3qlWhwcLipG+exG5YeDADa8cfuZxnBdBuSi7QdBxotKSR7IRkWN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YD1J5puj+Z+eSkss/+6/bdD8x5vpKGbefe+lXQZyLYgFFBHG7X+hRWtyId8w?=
 =?us-ascii?Q?mgcJw21MClXArJbgZ7mySJlAA+QDAznpwWnj92vsejH+w3V31jjRRaOdi7b9?=
 =?us-ascii?Q?JwSqTuX83Rv5cWU/gfut7dRQJCalC0AaIZPyi5ovDDY1Kesq1MXe4KMqf2UP?=
 =?us-ascii?Q?8FHYCNXeGfbPf+ya0oT4g+e2leXJrzcFGxfAcXfGH6KhPUr5GViIqf5R/H6Q?=
 =?us-ascii?Q?SfkJ7Uee/V8b5tluLOxtthbYJW4lJ2htA+Dx5MH2KeSSL8rJCFHvQGl8jtnI?=
 =?us-ascii?Q?cY2CMKFfQwCZc/L6452G2wp6ejDV7ndmcxnSd0xQ+2aKTbRoliRpRdRg+ykv?=
 =?us-ascii?Q?3orn6RyZ4x6cgkLhAOg6iIyu9Hoy9hgASfeUFPdyCUTC4V0JaSm9e7rI/7ho?=
 =?us-ascii?Q?aJCu5O8mMtLQY6gFWDVPM4D+Ta0/yVGFkdLM6LxPQlZzrkHwMS0xzG1HboV1?=
 =?us-ascii?Q?nmWt42CWtnMeOEw//u/uSVZUGml7yZlnEkEDtkdYQfbTwlAH+C0LundlT8QY?=
 =?us-ascii?Q?Bz68zC7CbjpTXVbqIr0CymhK0XkPffj+YzcZbjlQKl31S2THI1X/OZI05aUz?=
 =?us-ascii?Q?rs2SJBQnJHlLBkGWJX9QhBtoMCeLUifrqgBKPnLRRHK5/nQgijlCTiItBHd3?=
 =?us-ascii?Q?iMUom7azIWGzKZdBgdZDMzMXT2sgLa/my0Br18ORbCyB3sRLD73ETFINlJCQ?=
 =?us-ascii?Q?qVOrJ+HC8rYEv/01RGXCW/RriqPQhlz0did7wcdqhr1gciGMXlI1sHtZjiOA?=
 =?us-ascii?Q?OijH6jTLUKDATwTXW8+2z2R3t7QxLIm35Ssp3OQJpj23quT4djs0uVdMcDpw?=
 =?us-ascii?Q?bPZ+HTcvMV2/kqFqLcVCnyVIL9Uh/RQjPtWQI8x69DxSjCC7VERQTaURyBsr?=
 =?us-ascii?Q?LIc5MiTburZ38TVVIkCpe8Xf9AC029UtuvrNTTZtZ9JLKXAAR8Cw6HBBxP1Q?=
 =?us-ascii?Q?5/GOczB6wytqPTI2d5XYqzwVVLATekUECyif/wRByLkB59MTc9QpnTmbsMHH?=
 =?us-ascii?Q?+l5L0MFMGAxmn068u6DEGH0Qo+jQ3wVFQGEvzLBCh5Fm1eShI1b9uxv3/aaR?=
 =?us-ascii?Q?y0vWpz+9oCU/yrqHb5e3/wZFkr1XRsCRQHZIXpn1mk4mtfTkMJxJ36GnBPLY?=
 =?us-ascii?Q?SIriJN5c5mcIeAy0PC0XI2uXX24w3T/p6Q6uqAd/isJdibd0sgWbwz1mwZ3D?=
 =?us-ascii?Q?FRmo0MWo+r0dNt4wb0nxGxnLCYMBQ07hX+9TJLn0tnTmegPrr2HqDqpH26pc?=
 =?us-ascii?Q?5ZLw8nA5AG5nhS5vgKbRKVwB5WTk2GCJjenPur0mS0OTpUg0KT7oJ64MXZzi?=
 =?us-ascii?Q?/WyWcDGo6QfigZLWXVNlY9zSKZH51BZv8tC8J8fRKNKhl9a2eyI4TMASbf+b?=
 =?us-ascii?Q?XBLnNHr3S3c0tbGLvOXWFu9FevxchlX/g+OyIn01giTTJ6i88F+6mDFKjbi7?=
 =?us-ascii?Q?iOVsbJk5mne+DWCoaqHP+Hs1NoiPPjd59vKEa7hdoeTU4gN2l/2Gead0Nh7n?=
 =?us-ascii?Q?gJOdyKIqAPzoJrhxIlBjsDsEngCC3DJxXeCjtjOluGUQHdLP8bmY+sM6fwX1?=
 =?us-ascii?Q?QniE0vqysVBIHLtebHvnHgW8xZH9g7NlFb8r+kHQ?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb7a781-b404-4597-e14a-08db4affc69e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:21.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vsu75w6Omb8JCAXsAl5P6usgcIpeXLRVcP/1SkpMbNfMVn/FeM6pt2fJpRYhp37MNmuOSUTfK7UROpac8jmmgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6648
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding following functions to eventfs:
eventfs_set_ef_status_free()
eventfs_post_create_dir()
eventfs_root_lookup()
eventfs_release()
dcache_dir_open_wrapper()

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 188 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   2 +
 2 files changed, 190 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0ee27f7c8..f047e45ed 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -208,10 +208,198 @@ static struct dentry *eventfs_create_dir(const char *name, umode_t mode,
 	return eventfs_end_creating(dentry);
 }
 
+/**
+ * eventfs_set_ef_status_free - set the ef->status to free
+ * @dentry: dentry who's status to be freed
+ *
+ * eventfs_set_ef_status_free will be called if no more
+ * reference remains
+ */
+void eventfs_set_ef_status_free(struct dentry *dentry)
+{
+	struct tracefs_inode *ti_parent;
+	struct eventfs_file *ef;
+
+	ti_parent = get_tracefs(dentry->d_parent->d_inode);
+	if (!ti_parent || !(ti_parent->flags & TRACEFS_EVENT_INODE))
+		return;
+
+	ef = dentry->d_fsdata;
+	if (!ef)
+		return;
+	ef->created = false;
+	ef->dentry = NULL;
+}
+
+/**
+ * eventfs_post_create_dir - post create dir routine
+ * @ef: eventfs_file of recently created dir
+ *
+ * Files with-in eventfs dir should know dentry of parent dir
+ */
+static void eventfs_post_create_dir(struct eventfs_file *ef)
+{
+	struct eventfs_file *ef_child;
+	struct tracefs_inode *ti;
+
+	eventfs_down_read((struct rw_semaphore *) ef->data);
+	/* fill parent-child relation */
+	list_for_each_entry(ef_child, &ef->ei->e_top_files, list) {
+		ef_child->d_parent = ef->dentry;
+	}
+	eventfs_up_read((struct rw_semaphore *) ef->data);
+
+	ti = get_tracefs(ef->dentry->d_inode);
+	ti->private = ef->ei;
+}
+
+/**
+ * eventfs_root_lookup - lookup routine to create file/dir
+ * @dir: directory in which lookup to be done
+ * @dentry: file/dir dentry
+ * @flags:
+ *
+ * Used to create dynamic file/dir with-in @dir, search with-in ei
+ * list, if @dentry found go ahead and create the file/dir
+ */
+
+static struct dentry *eventfs_root_lookup(struct inode *dir,
+					  struct dentry *dentry,
+					  unsigned int flags)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *ret = NULL;
+	struct rw_semaphore *eventfs_rwsem;
+
+	ti = get_tracefs(dir);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return NULL;
+
+	ei = ti->private;
+	eventfs_rwsem = (struct rw_semaphore *) dir->i_private;
+	eventfs_down_read(eventfs_rwsem);
+	list_for_each_entry(ef, &ei->e_top_files, list) {
+		if (strcmp(ef->name, dentry->d_name.name))
+			continue;
+		ret = simple_lookup(dir, dentry, flags);
+		if (ef->created)
+			continue;
+		ef->created = true;
+		if (ef->ei)
+			ef->dentry = eventfs_create_dir(ef->name, ef->mode, ef->d_parent,
+							ef->data, ef->fop, ef->iop);
+		else
+			ef->dentry = eventfs_create_file(ef->name, ef->mode, ef->d_parent,
+							 ef->data, ef->fop);
+
+		if (IS_ERR_OR_NULL(ef->dentry)) {
+			ef->created = false;
+		} else {
+			if (ef->ei)
+				eventfs_post_create_dir(ef);
+			ef->dentry->d_fsdata = ef;
+			dput(ef->dentry);
+		}
+		break;
+	}
+	eventfs_up_read(eventfs_rwsem);
+	return ret;
+}
+
+/**
+ * eventfs_release - called to release eventfs file/dir
+ * @inode: inode to be released
+ * @file: file to be released (not used)
+ */
+static int eventfs_release(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct dentry *dentry = file_dentry(file);
+	struct rw_semaphore *eventfs_rwsem;
+
+	ti = get_tracefs(inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	eventfs_rwsem = eventfs_dentry_to_rwsem(dentry);
+	eventfs_down_read(eventfs_rwsem);
+	list_for_each_entry(ef, &ei->e_top_files, list) {
+		if (ef->created)
+			dput(ef->dentry);
+	}
+	eventfs_up_read(eventfs_rwsem);
+	return dcache_dir_close(inode, file);
+}
+
+/**
+ * dcache_dir_open_wrapper - eventfs open wrapper
+ * @inode: not used
+ * @file: dir to be opened (to create it's child)
+ *
+ * Used to dynamic create file/dir with-in @file, all the
+ * file/dir will be created. If already created then reference
+ * will be increased
+ */
+static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct inode *f_inode = file_inode(file);
+	struct dentry *dentry = file_dentry(file);
+	struct rw_semaphore *eventfs_rwsem;
+
+	ti = get_tracefs(f_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	eventfs_rwsem = eventfs_dentry_to_rwsem(dentry);
+	eventfs_down_read(eventfs_rwsem);
+	list_for_each_entry(ef, &ei->e_top_files, list) {
+		if (ef->created) {
+			dget(ef->dentry);
+			continue;
+		}
+
+		ef->created = true;
+
+		inode_lock(dentry->d_inode);
+		if (ef->ei)
+			ef->dentry = eventfs_create_dir(ef->name, ef->mode, dentry,
+							ef->data, ef->fop, ef->iop);
+		else
+			ef->dentry = eventfs_create_file(ef->name, ef->mode, dentry,
+							 ef->data, ef->fop);
+		inode_unlock(dentry->d_inode);
+
+		if (IS_ERR_OR_NULL(ef->dentry)) {
+			ef->created = false;
+		} else {
+			if (ef->ei)
+				eventfs_post_create_dir(ef);
+			ef->dentry->d_fsdata = ef;
+		}
+	}
+	eventfs_up_read(eventfs_rwsem);
+	return dcache_dir_open(inode, file);
+}
+
 static const struct file_operations eventfs_file_operations = {
+	.open           = dcache_dir_open_wrapper,
+	.read		= generic_read_dir,
+	.iterate_shared	= dcache_readdir,
+	.llseek		= generic_file_llseek,
+	.release        = eventfs_release,
 };
 
 static const struct inode_operations eventfs_root_dir_inode_operations = {
+	.lookup		= eventfs_root_lookup,
 };
 
 /**
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 57bfd1322..268450d60 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -68,6 +68,8 @@ void eventfs_remove(struct eventfs_file *ef);
 
 void eventfs_remove_events_dir(struct dentry *dentry);
 
+void eventfs_set_ef_status_free(struct dentry *dentry);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.39.0

