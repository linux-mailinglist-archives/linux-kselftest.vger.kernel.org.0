Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50526F42AC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 13:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjEBLYh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 07:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjEBLYb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 07:24:31 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013011.outbound.protection.outlook.com [52.101.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C1326BC;
        Tue,  2 May 2023 04:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIcpvnKYcS5nIoTyXgp5re9TnI87RjrDOgzv6YHij0J8f4OFNQZrJaYdt/S0dzlQ9DuZF/gCE3VNGVCsbl2UYYWkKVCS3A3sBBEvUN+Gzf7ZaCfRs0EPyPuvFEh5vPEd1EHquKecOpqRiOx6K8TH7QKCeiC8i9bQTIJLvungElaqS65dtaDJK+LTUMcNqYEWoJvTglPI/DKsabhWlywerF9xdl5SNXaSLxSU3vcykhbcwAEUjRODztNGUtrLnHFBEFZxdgjTt5eNoDh6yKox9IH9CjktuOHZOH3XR2zCeMVg/gy1iIyDAUfVHgsNscyy34neE1VLhpWaP4A6hLQ5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkRu/CB8vMVQrWr2u8LNHjVjzlQsYbcCGubmZWaeChE=;
 b=WinxD9rKQ1AynDWymNqhJ7CH8da0Kobv2K7TXAnjdS9QCUxv4anh+W/G8ktGxtgmDuUuwmiAmkmKYLmw5At5lFR6GwcoeCTWwXDLahoebn3vaH6E4XYFg4nmy3I8Xs6bsrW4v6Gh7IH22hLOw6Xq+Qn4Flpi5M0xtHyeaDctjU8Vcf/Sz8nxkCTeGYxeRP9xU2MpyvxOb4Nw7u2rPwWDqZP3AcN1b8Cj4e66pK2F5fqLWx9FXEUk+zjq92hEOBugv5nTLMQhCVKAy5tVb1+BJhtObJ+6u706A9wyjXRK7Fl8jvvAb62zMMTDDU0szX3iQJvR4SxuhYNkFkp/ocp9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkRu/CB8vMVQrWr2u8LNHjVjzlQsYbcCGubmZWaeChE=;
 b=JHNb9lJ46bKGMGYuTNoGJR58o9iC0ImMccZAgT0Y1mvUFzmBHBMCO1t/RxoTBICjaS0iUg18cDk10xrC2MDpLw6+7iwZaWT9ZddoESORLtIufakpeRBXhYyVmaQ122eSmqc+xe0aUpNpSAi4v4GqRg9Qg5T3lJ6OyEiCA3JU5Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by BYAPR05MB6648.namprd05.prod.outlook.com (2603:10b6:a03:ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 11:24:18 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%7]) with mapi id 15.20.6363.020; Tue, 2 May 2023
 11:24:18 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsab@vmware.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, vsirnapalli@vmware.com, tkundu@vmware.com,
        er.ajay.kaher@gmail.com, Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v2 3/9] eventfs: adding eventfs file add functions
Date:   Tue,  2 May 2023 16:53:14 +0530
Message-Id: <1683026600-13485-4-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: f51eb987-cf43-406a-0108-08db4affc4af
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OqqHCpICWtRJRbo3EKvDCbGgItYW2Ix0S3DwcfwYI/bsreMatYBO++VnKIZREUOEjT32I/s7WcfszNjUyirAkSmGSze6le303rkPYAZ2cR3ZF3bcYnDtfFJzZ8v+k5X+/5+2kssC7OFAVF4Td3uujJCNBN6V1kNRXkr6zNrq65VdUxdoqiwxk9PTDTp4GXa0pLueMPB1nicfPH2Qkzul5Oy4t3J0uSUgp/hgkKMEAY9YBEUF522lKmuZNUjlQmXNJu4ZmjLCUHEGpvYBcnhVmbuDjJI7d9bKKUDRzJ7ED2D+sL8SVLwthlFxG/EU4a0yI7T1Xrkw8KhS/Q/xY+nFRLmnIH1+ySSM46CVUk0OMooGt5dvqXjkxQTDDYNjIo+fgN8tMaTwajTTSanK0P5ZtYkkiFWwHBr5wm1jraGM6lCBzZvyzkLm2HwsbI6AaNEbzZbbUJUil9k6t84Nkeh8fB/9xmXXUDcd2MKMtjv+jF57AEh4v/pjRwYZN7sPF0WU1KDIVSFE3Pm2c1R4RajSJxz3AzQ2t80syZMZN1XVm09S6atHQy46iwgwJacVpQhguZUuGX+ZVcqdcR5Z7q+4lZK4t9N5vAj2b15MCCcSMRVa2zF4vtBfMl47TkECqaxK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(6666004)(52116002)(107886003)(38100700002)(38350700002)(2906002)(86362001)(41300700001)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(5660300002)(8676002)(8936002)(36756003)(6506007)(26005)(6512007)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQDFrLKKBNilCyJ2l4gmD29GZcySK8buURRwvm9Df8l65KHws6GwwMuBRkpX?=
 =?us-ascii?Q?xJxFQ0ntfvyfrinytJkbVTZsAL6+hdyqp1+Go2naOzOrVvNzZBlYN8vXK04U?=
 =?us-ascii?Q?Qt3wKZx7HW/0uG2bmByH6N/1J48ko+lyylO69DYT3Apt+4aaxkC23CJFU/Hu?=
 =?us-ascii?Q?qpfveGj5yVS3SGVCI0Bwjgx3J7RzhBSDb6QRIJw3j0HV38upwBqmUrsMPV5e?=
 =?us-ascii?Q?o4G1zpU7oHX+dnpwbU1r1d8gnOnyb+jwTvpUmDiDVQ18kUT5avPyEiMOWiI7?=
 =?us-ascii?Q?h/u5s8/iyHMm+TnCNjpzdfjD+dm+qh24j/l46y77o02TGEeMg3uKCkaV1Hyf?=
 =?us-ascii?Q?8Dv3BC22TG/4J/MXoMNiyxC02pQj+2uFER5pC3KFEUqLP/BtUBntC/XAwhUH?=
 =?us-ascii?Q?2jO1RV2KtRxfCPQ3l5XnP5jY+7piY9uyhl2W1DOmX24rO6OEuJppMyzanqyS?=
 =?us-ascii?Q?cyUUzCAGxmF2K+J2X9OH0/Sd1xYYfkhoawUYlDm0lRwmBtVUAbpo39LDvLQO?=
 =?us-ascii?Q?asPtT3SZxA9GtWRa/jxVY283qQAM4Cl+ZzQEeh1UDFANSdHjGtvJENGN7Rjl?=
 =?us-ascii?Q?Wx44/57fy0dzZ/xf5fb4WwP+JDuGAW+GONhwIudQq3MT8e07yPxMCbQy7fwy?=
 =?us-ascii?Q?RcsRC0bl/zm08CcxDRHY/fCVxsaA4MpSZE+M4ZijrLZY6c2+Jxf0bPWQROCF?=
 =?us-ascii?Q?VL/kMKU5xHHk5tbQr4TJUrr3CQImbjsznsagfNp744c2jpeobaGdDNDRrUmq?=
 =?us-ascii?Q?aARo7TAo6gnWI4qcAJylSyLv3iNbk4lc7N027V6kGKW76DGprzSfxm2IYOgR?=
 =?us-ascii?Q?Q/FVArWmHwHbjZw1M4aBRegBSW/R5DbO4VlBIMgEYqG0U92oK22+QGHJLciJ?=
 =?us-ascii?Q?owW64gQNH5TtRpy4gF5ty/639jGHODeWD813Cz/rM0dmtYG4lf6kv0m5kXb/?=
 =?us-ascii?Q?9t2H/xbofUynwTC6JioBGjLLsazFCzTecVzoT06YaGXlQ8XIk0nbOApcrW4a?=
 =?us-ascii?Q?ScKSguu4xxwBRn1El+oWAL2efEJLqiSh4ZSB//eqY6YZsRkBrVjMs8UjGKLq?=
 =?us-ascii?Q?PyneQZuWmH0RLzolKD+bUUB2798xoWqF9WWVfL60GHol3qTKZnkstGP9Pmre?=
 =?us-ascii?Q?OOHS1+yZLdt5ppcJkMqYGdleHUfqijTuwhZGopeN3laN2z5vEZhdoLzkzC7D?=
 =?us-ascii?Q?kI+e+4Hcd76UHgDqnPeWQDnWlduEykHcvI81M9Ae8gCKfEPQW3iyCKbybo+H?=
 =?us-ascii?Q?1b2MVSP2C9la1FR/gcZm7iV/3tiNblIEkhLHB1yLQwLBcxadWgZkJz/9NqZU?=
 =?us-ascii?Q?riwdX8TeKPcWyNUEnKF19207AXoDWNEef7KmAxT+sA6Jos4L3lZaPlf5fC/3?=
 =?us-ascii?Q?xFugqQShswmzie4N853sPS1Wu+ZXwP5Z0DDBIiVR1ZsSX3y3sDWn9C7bazxG?=
 =?us-ascii?Q?dNHWVqoYL05uWITzpH2wmucEv8UWnTaYCpQcoP4Fl+wOIsmZaDP3mtcbwMuZ?=
 =?us-ascii?Q?kSRfHLMmQ5ZV8hN9EcU9XdR/ubpa4IIccZw0bl9JR97ohrsLc7BCiH5QE1p+?=
 =?us-ascii?Q?KJOexwOsV1CPn2j8w6DcBO0tldmkqIKwo+klHv/Y?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f51eb987-cf43-406a-0108-08db4affc4af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:24:18.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxMSKpf/0AX/Hs/TclOLGw3vWKJW/SS1DeSpqCj2yiR9Im8BzDx7zr8/RDb+vSpg0HJY8E+lAYatqWZpxCOCcw==
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

Adding following function to eventfs to add files:

eventfs_add_top_file() will add the info of top file
to eventfs and dynamically create these files as and
when required.

eventfs_add_file() will add the info of nested files
to eventfs and dynamically create these dir as and
when required.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 118 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   8 +++
 2 files changed, 126 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 82caba7e9..93134ae40 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -250,3 +250,121 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 	eventfs_up_write(eventfs_rwsem);
 	return ef;
 }
+
+/**
+ * eventfs_add_top_file - add event top file to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is NULL, then the
+ *          file will be created in the root of the tracefs filesystem.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This function adds top files of event dir to list.
+ * And all these files are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+int eventfs_add_top_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fop)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+	struct eventfs_file *ef;
+	struct rw_semaphore *eventfs_rwsem;
+
+	if (!parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	if (!parent->d_inode)
+		return -EINVAL;
+
+	ti = get_tracefs(parent->d_inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
+
+	ei = ti->private;
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return -ENOMEM;
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		return -ENOMEM;
+	}
+
+	ef->mode = mode;
+	ef->data = data;
+	ef->fop = fop;
+	ef->dentry = NULL;
+	ef->ei = NULL;
+	ef->created = false;
+	ef->d_parent = parent;
+
+	eventfs_rwsem = (struct rw_semaphore *) parent->d_inode->i_private;
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ei->e_top_files);
+	eventfs_up_write(eventfs_rwsem);
+	return 0;
+}
+
+/**
+ * eventfs_add_file - add eventfs file to list to create later
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @ef_parent: a pointer to the parent eventfs_file for this file.
+ * @data: a pointer to something that the caller will want to get to later
+ *        on.  The inode.i_private pointer will point to this value on
+ *        the open() call.
+ * @fop: a pointer to a struct file_operations that should be used for
+ *        this file.
+ *
+ * This function adds top files of event dir to list.
+ * And all these files are created on the fly when they are looked up,
+ * and the dentry and inodes will be removed when they are done.
+ */
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent,
+		     void *data,
+		     const struct file_operations *fop)
+{
+	struct eventfs_file *ef;
+	struct rw_semaphore *eventfs_rwsem;
+
+	if (!ef_parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	ef = kzalloc(sizeof(*ef), GFP_KERNEL);
+	if (!ef)
+		return -ENOMEM;
+
+	ef->name = kstrdup(name, GFP_KERNEL);
+	if (!ef->name) {
+		kfree(ef);
+		return -ENOMEM;
+	}
+
+	ef->mode = mode;
+	ef->data = data;
+	ef->fop = fop;
+	ef->dentry = NULL;
+	ef->ei = NULL;
+	ef->created = false;
+
+	eventfs_rwsem = (struct rw_semaphore *) ef_parent->data;
+	eventfs_down_write(eventfs_rwsem);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	eventfs_up_write(eventfs_rwsem);
+	return 0;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index aeca6761f..1e1780a61 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -50,6 +50,14 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 				     struct eventfs_file *ef_parent,
 				     struct rw_semaphore *eventfs_rwsem);
 
+int eventfs_add_file(const char *name, umode_t mode,
+		     struct eventfs_file *ef_parent, void *data,
+		     const struct file_operations *fops);
+
+int eventfs_add_top_file(const char *name, umode_t mode,
+			 struct dentry *parent, void *data,
+			 const struct file_operations *fops);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.39.0

