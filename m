Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED10752001
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbjGMLeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbjGMLeM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:12 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB9F2703;
        Thu, 13 Jul 2023 04:34:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBZYkaKD9lT0QyakyiVSz3tpOxLJ8HnhOZmqFnivj1gNogk5tUWW8ScgmiAP7VunkOGLMyR1I0/xY6GLDSNkqE6r3JMxWfYQsBJ3ZlaymVcqOgG6SCowZOX9y3DSnijN3wme+3i3RfjalEM6L38FXCEZDeXjoCC5TpTWKmAEZ0skGWUlFETz6r7UD9JTGhRUstcfayBEnNq82bA8KYtM+15zXbXMVAbvsp6l3og7GHfkC/Ce60pvC3F1duJqLV24cJLOpslDhUumJhWGqJO925UmHXmJ/Kgkw8n5po6NpE8n/bPsr4nKihPWjZLJSWUvvFTZcvLbkT9/ff+9qxmVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=za261eOrAm5M/t/4dj4NiMjZypajcEaCNE13hkKeW/E=;
 b=LuelkCHQBh3LgXu0oh3jX9I4SdO2LXWhqM7erdOrFnje9XJHJAp+hsRpgYAU3W1skWoMbDOSg5Htjdv0gWsq+vE64LlSFPuDOCxudqiZQSeMHhBLC9Xaaxjjk0r3kVojFO8y8DoBOQ1FNRM4rhkVeAYMnk3w9rEv0ot145z+Tdreuky31U6q/4dsssPaMHmPSN6zoJhVJJ5Sk/jcW8QyWWZVYrVj5xKQLiNgzf3UZc2P5O7bbVwdQz8DkAtO814gTAgm3FKfFmnMqJ/PVdeuFU8+iYj9OkhJ742l4S+7vxlI9se8k408bVgkQjEWus3wtZLYK4Hq9EpQh/84ii5TWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=za261eOrAm5M/t/4dj4NiMjZypajcEaCNE13hkKeW/E=;
 b=FKzC/nC/BpT23Rm94JW/oDAurarYanNRl0A0Jg9Gp1zQ/coVsiFe2M4tpYGzW12nCQkUPoAzOVEmh19b5C9ddPr5V6RG/azzSsLAnD8aCei1fEWM2fbrzKEMEGE6+Ff+1+lz0XhbD/rqV+me6kW1HYRV9KGOn2L0gs0uJjXvbHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:34:02 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:34:02 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 06/10] eventfs: Implement functions to create eventfs files and directories
Date:   Thu, 13 Jul 2023 17:03:20 +0530
Message-Id: <1689248004-8158-7-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1689248004-8158-1-git-send-email-akaher@vmware.com>
References: <1689248004-8158-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|PH0PR05MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: c2009981-6dc8-45c6-8d17-08db83950eb3
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+zGcaVwFk4FnEQVZEy9AcGCNXlwmAyeIKmei/bFP95mtAOyD05MInmuBz3FieVwywbd05iGpj/qSAYkjTiTeD2TxxcEad7MyvfflJ1QqytMoDvh8VXwEwWR8euwYyx1sw2TF50sKxpe53+kBRZCA9Dlmmvy9ZSITU0FEo51nQ/RZ5WRAak43nUE7kIKEqMDHt3ig+xqYYkioWkUdbb/Z28VlqCxLMXzDRI8K6cjI7Rp4dbFaIq9OyN7YeID9vXIiFjqNKffALHCtrJXpQ3Zz17MxULlHzmC2sfZyyBZwMZbMkuBc3/Wj37H04v5uztGsCXjHgO51UY3nZM4aOTqtcB8NVWruunD+N7YehB9xA7y3Xwaa0SUMQfZIPkEPAv7XHy0vNOAesS4FnKE1GIZGoefbR56D+BjI2NHmPz6bL7cnc3057lO0lMdStDVVcAUJ/yRTwbTKcOwG0i7JHsqJaTpj2H5cQqF04D/X8Gk3+l/uRT+s/aRcrQz8JVpsLwIMtRUvsnWaFjyQLWnO2P+N5L+gRSIheEbSY+HtOQqMLFfj3ya5KvNuVOnPjdfVDoJtDzFbT2NdH0O53lonFTd/VSwimp/xxH2fUSqrEjxxibf7ZtX8qGkIaek+LNdmYRnhTFM90XxKuFjAHrXJ3NnMIWlsLgxHJXIIcOGWWxmsoM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Yox9X0vlwHSXFzqwyPXsUrKbXTbDhiFg6hRNdUrm6bMfZM16CSfuf68VllM?=
 =?us-ascii?Q?PDSuWPl8iJbeeetRAaNlNWiv2IsYtNj06vDze62I2+6toIBtGJz50nV67sGa?=
 =?us-ascii?Q?V10UaT12mit2HXu3g2S/ZjIINF2Q4XUT/JJcCkoxHRw/3Mq3kJEGbZOskiFJ?=
 =?us-ascii?Q?Dm4mlGrAxk8ey1is4fvATwebsVCpGSf1XWG0L2UCiSZPdmGaFmo9vhkNjcSa?=
 =?us-ascii?Q?ErmsGHezFw7S6zCF7cm73DzjTnFKAhJDRxLYQJNc5dioATFEpGM7bV8iLc5s?=
 =?us-ascii?Q?kJO9Bn4mS50zZx1/3Yc2lMc13MsauyRjMtjFAAKxLebalV692BU8hn1tZ6Dz?=
 =?us-ascii?Q?WPXREX4JLuO7GujtAr4MXpjURNMK8Fzamsh0P/Pib0hYWL/PQgbjG1qwb3zN?=
 =?us-ascii?Q?nRl31BPQT8NJZvuvwHqnSERr4tMvUnDmYDDr0fVJi3Iyn/CYNXBF+pE8WpWc?=
 =?us-ascii?Q?XFWYr30e0PiXLPxsy6hC1AVnkuXPyosaWpRuDQV3HASsGco/rX0j13pK67Xd?=
 =?us-ascii?Q?MmyRH3W7E4dkAt+AaGJ9PbeuJ5SkpJO5MZvHhQIiP+wY4fgpxFpVzS1CY7VB?=
 =?us-ascii?Q?sxK8Kjf3sewg7MIKaqnK7a/+oGxnbtLMhq47luxTO2E6GzMQECJR/Flq9rI8?=
 =?us-ascii?Q?yanZ1ovVCJvuxXxHi1qxmIfgl5/M15N/CKdVugXq81DubH9BMBdWusP6WSXa?=
 =?us-ascii?Q?jKm/dNzRtado7A1ER7i+u5QNUT6qYacluD5MGPd9UupOjm0Q3cKTawGmueLX?=
 =?us-ascii?Q?KhOnjIM5v9RbRT4s+RuL4sQwdx6suPfeQlNQSdy46Oqy3N+BDQE/fQE6iuu+?=
 =?us-ascii?Q?Z6SXdCIT+6ELXO6/g5igfKMzoSEPpCHpJfPFa4CtlTLrvTlNlX4g+Fh9TYIX?=
 =?us-ascii?Q?b/m7yCRr6L7B8Af15cyOaYgnZBQzpl4wm4I0D09t3tePxlnCzKSC8/2BE6Tc?=
 =?us-ascii?Q?5cvpicRiF0XyEHS372K+40uFVzlJ770e/209GyxXi2P/85rmU6M+xPVTGxB4?=
 =?us-ascii?Q?At6PLezYybLw4ytQPQGrJuGACBwkQzTpg78JRp8DuKeQnTcsvE0P3PwEL/Ej?=
 =?us-ascii?Q?B9/Q4d2yPPgmSXbRCQptIb8QEfTbHLf9M+6lU65lJZRhBSRD0TPnYUaLoIl0?=
 =?us-ascii?Q?hPELR4iW3IsB1hGduf4/RYChiof/tzF6AI2d9R9ebsp+OnoD/5v9wdJUewpU?=
 =?us-ascii?Q?FNA22GrcWVPXfRiUm3OZf4QDrJXDgI30EA4+8u7RloSmZqvpbjETt8L8isPA?=
 =?us-ascii?Q?nZ0FtoTJuMCl3zH7x/4xX9x9RcT19lTYUkNX2rpiiRl9deZRKpzS0octFXGo?=
 =?us-ascii?Q?AxsSrvg/xXUAXaYdf+c4m3qTynQWDhASbsSOKjFAdS/AfmBAcVT78EGYYLgs?=
 =?us-ascii?Q?HCZLUPQpFrQch5GudYoJO5kQi3pnQGF/hIszsOkFUdU5Yq6fb/N9uzdd1ERI?=
 =?us-ascii?Q?B8K646x+MNZgSZ6e1eTmemJI2mrrPV/kWD9yshgFqr0zQC942dPtneu0Ne9W?=
 =?us-ascii?Q?kPoAoZAkjx/GDEHSQGOjrxj5K98oTnhUxHChNebqtTZ+qdfUfV2SuZf0Bk+D?=
 =?us-ascii?Q?vqqiY/6Bg5c//05kaRwKBmnQHNbxF6hI8zSnoyk+?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2009981-6dc8-45c6-8d17-08db83950eb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:34:02.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjO+ObImvLzZAIktIyOJOiYS7ig0F5ucOGkdy9VDEPCslpJh4vOrD8Uo7uHxysHRiFgGm7UFg5nzap0b+ETJ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding create_file(), create_dir() to create file, dir
at runtime when they are accessed.

These function will be called either from lookup
of inode_operations or open of file_operations.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 110 +++++++++++++++++++++++++++++++++++++++
 fs/tracefs/inode.c       |  47 +++++++++++++++++
 include/linux/tracefs.h  |   7 +++
 3 files changed, 164 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 322a77be5a56..34b5d3d8005b 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -46,6 +46,116 @@ struct eventfs_file {
 
 static DEFINE_MUTEX(eventfs_mutex);
 DEFINE_STATIC_SRCU(eventfs_srcu);
+/**
+ * create_file - create a file in the tracefs filesystem
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ *        The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: struct file_operations that should be used for this file.
+ *
+ * This is the basic "create a file" function for tracefs.  It allows for a
+ * wide range of flexibility in creating a file.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+struct dentry *create_file(const char *name, umode_t mode,
+				  struct dentry *parent, void *data,
+				  const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (WARN_ON_ONCE(!S_ISREG(mode)))
+		return NULL;
+
+	dentry = eventfs_start_creating(name, parent);
+
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+	d_instantiate(dentry, inode);
+	fsnotify_create(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
+}
+
+/**
+ * create_dir - create a dir in the tracefs filesystem
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on.
+ *        The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: struct file_operations that should be used for this dir.
+ * @iop: struct inode_operations that should be used for this dir.
+ *
+ * This is the basic "create a dir" function for eventfs.  It allows for a
+ * wide range of flexibility in creating a dir.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the tracefs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, %NULL will be returned.
+ *
+ * If tracefs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+struct dentry *create_dir(const char *name, umode_t mode,
+				 struct dentry *parent, void *data,
+				 const struct file_operations *fop,
+				 const struct inode_operations *iop)
+{
+	struct tracefs_inode *ti;
+	struct dentry *dentry;
+	struct inode *inode;
+
+	WARN_ON(!S_ISDIR(mode));
+
+	dentry = eventfs_start_creating(name, parent);
+	if (IS_ERR(dentry))
+		return dentry;
+
+	inode = tracefs_get_inode(dentry->d_sb);
+	if (unlikely(!inode))
+		return eventfs_failed_creating(dentry);
+
+	inode->i_mode = mode;
+	inode->i_op = iop;
+	inode->i_fop = fop;
+	inode->i_private = data;
+
+	ti = get_tracefs(inode);
+	ti->flags |= TRACEFS_EVENT_INODE;
+
+	inc_nlink(inode);
+	d_instantiate(dentry, inode);
+	inc_nlink(dentry->d_parent->d_inode);
+	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
+	return eventfs_end_creating(dentry);
+}
 
 static const struct file_operations eventfs_file_operations = {
 };
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7ef3a02766f5..7dc692a5fee1 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -451,6 +451,53 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
+struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+	int error;
+
+	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
+			      &tracefs_mount_count);
+	if (error)
+		return ERR_PTR(error);
+
+	/*
+	 * If the parent is not specified, we create it in the root.
+	 * We need the root dentry to do this, which is in the super
+	 * block. A pointer to that is in the struct vfsmount that we
+	 * have around.
+	 */
+	if (!parent)
+		parent = tracefs_mount->mnt_root;
+
+	if (unlikely(IS_DEADDIR(parent->d_inode)))
+		dentry = ERR_PTR(-ENOENT);
+	else
+		dentry = lookup_one_len(name, parent, strlen(name));
+
+	if (!IS_ERR(dentry) && dentry->d_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-EEXIST);
+	}
+
+	if (IS_ERR(dentry))
+		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+
+	return dentry;
+}
+
+struct dentry *eventfs_failed_creating(struct dentry *dentry)
+{
+	dput(dentry);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	return NULL;
+}
+
+struct dentry *eventfs_end_creating(struct dentry *dentry)
+{
+	return dentry;
+}
+
 /**
  * tracefs_create_file - create a file in the tracefs filesystem
  * @name: a pointer to a string containing the name of the file to create.
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 2c08edd4a739..47c1b4d21735 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -23,6 +23,13 @@ struct file_operations;
 
 struct eventfs_file;
 
+struct dentry *eventfs_start_creating(const char *name,
+				      struct dentry *parent);
+
+struct dentry *eventfs_failed_creating(struct dentry *dentry);
+
+struct dentry *eventfs_end_creating(struct dentry *dentry);
+
 struct dentry *eventfs_create_events_dir(const char *name,
 					 struct dentry *parent);
 
-- 
2.39.0

