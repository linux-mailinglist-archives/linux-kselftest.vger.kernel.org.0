Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0680E751FFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbjGMLeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjGMLeJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:09 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84C626B5;
        Thu, 13 Jul 2023 04:34:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy1SKoBXkaVSJS4RLgyw09SPnzFrWBYoB9xsS2GK2uwuNyqz0tnI1cuW2LEZkVluF+xyEZwVmDMrsKvUB+qhaPtvI6taq0SMXMn66zCez3C/fEOR7nWl5d1Ld3/wQFLTpHjB65EE5pdGXRC5kc8lzdfn9qJkbaVJWF/pDMltBI+3Y5of0LQ5/eFuCOsNq7AzhQqe6MvIPkyJ6ibiw30kx4YMlXxdxNDSpIEnRxvmeHdRMx56zPNqoUGWT/pAdOxV3cWwRw5F0qluyQswcmLaj2DEo8QhFZuBWPKQHqFRFWdcJF3F4tEB6CO+98aV7UWFNSwYw/a79USwwcMzP5K7Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCNzRWofBv3ZYpz5jL9vy4GWLe97GUL3JGspljJ8SMY=;
 b=YlA/4JYUh4X0W8nWieOWveU3YnT8kb3Fz2j7w5eQGqZHjx0xEoaghWEwyBUaspO7ia2CCDx5Bhid9SK9K20P/6eReqqPRqMEaX/gGSKb5XkIrvVVeBRdG+vCrlREzbc/OsJVFAMli74XPIBehO31Fuo+RWHWuw3YWKBUlMidx0QhIeUE9+3+faBc3kco+qjyrfCK6agAPM3hX+qsfLSjqfCJgmqsZkyVCBQ49T9RcAjhw7JmhlhZ5jVj78GtMVUiFSr1a8GoI1p8fE0gmKaFwGrsnyPBsKQ6hJTRtH0sl5XIe4jvFxhCqeZY3AoTik9WpKIyKgMy+rYgccJ5Dgszhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCNzRWofBv3ZYpz5jL9vy4GWLe97GUL3JGspljJ8SMY=;
 b=n9/VNCddk8Q5mFp0cxxs1AAFeYJXCGguolQt/UMJ+5jAOae4AltUfujS7vGJSYYeO12HN98y0s7QuIZqOR0ep34jgUuB3q4IwrESVW2kYC8tl+iBX63RaWhXt9zJLsS6vjqisPM59srLfgAvp6RJi66606FPVJ2Ysk+q/ixNXuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:34:00 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:34:00 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 04/10] eventfs: Implement eventfs file add functions
Date:   Thu, 13 Jul 2023 17:03:18 +0530
Message-Id: <1689248004-8158-5-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9016675f-566b-4dca-d30b-08db83950d65
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7xHGd3691aVXP9jIooK28wncynQgMGOIdn4kY0jLFhUJMTsn/8hktqB74TdBVjrfYNnbzSZYR3UVh7d/FS2iX251TT5vNONtSvaOen1d/Khpc94uftdPvrZEOArVPBaSra+jASVeKwyAYkEWvjNLv4zJ9TjFXDDwOf8yolQIjz7X8UK2OyHpqek9XVt94Jk5mwvPBOszi65SBhROppdECLXTVl1+QHJY3xiBQe826d52GNNAYZQFo5k243PioaYr5dzst+Nq38VooqnEkVI9Lch9TnmY6j/V9bBgCcRK1h/HWX0+hdXQyDqvVXat3C4AHBi7ql9Pl5zCijNun22Y5ftCbcfNZy3uKuEruN3JSRF/roR3VNnlqxP6uvdm2VJttsVVbbFcx5H0s74e97n82/hd6SKFhCidVrsh6pZ9HLMc9enF9j/R2l9EN/zxSFStNfh964cF8CbTrOrPXU+Zln5pqL4k/kfQf/N8aSer4IZVuOmxr4Lb5BZMgSF3moPpSZki/AeDWoRt2DNGtOv+Mnayoq9XPShJJM3HzKD+AYnwHu7/EB2KcgVwBEoffMGM/SlZJbTwfBAzQcGz/BI1qpnbeCdNfkVns5MU/RMt4eOtUW+qj2PlySgchhxiaY9hu/peaJ99RdAqbiI6Q+AACvfTl//oGfxjjc/zT4WXC8R+MJRm+5XX4g3SRNMzudJcefqi6yrYT7MdgZZuSY/Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(966005)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UUT93gTsVAD10dRnzeQgsRETPBn4ID4CxafD1t/EXQZK5BnAYNKMHIWn2MlU?=
 =?us-ascii?Q?XBVWe7m6w6sFgt5DZCrfyOpj15XqsckqGNFOO7fmGkOrFVjzrfSFx/yTAG45?=
 =?us-ascii?Q?zNznJSWohJWG0LXVMAhGOgceb93DmUvCD1D/bYp9ZM/1NInvclxHLjCvMqxg?=
 =?us-ascii?Q?5Z5pm8kMCHIyJoZHeSRjbexkGkneSCbZcFS3HeBCwnjKUtA43F+g8ARvYJl7?=
 =?us-ascii?Q?10oyDPnQAaJVmz0KR7j2CwPFA9aK1GbcwsjG+LDkxcvrG8RJipeKljYFDubh?=
 =?us-ascii?Q?pg595XPJ2R6a00rs0Yme64BbLJH4v4WMnhrwmyEvxyujRh8k86/ZfJQIaDoK?=
 =?us-ascii?Q?yoOiBb6HUl6XSzAuoTki3rWci4HM7hZr/Y0LlTSv6a+vvC7CYa/yatdG+Eyi?=
 =?us-ascii?Q?gIlh4TNm7/T1C6MG06SgU3tC8o8BPN/kbqjgrjsEs8NJhJMWt91wXrh5FFm1?=
 =?us-ascii?Q?pp996Ie9tMQfqmXLpU2y3RZjUOTYDJq9jKBwMdKGVPDWoOMPRVDjvFyEdt6z?=
 =?us-ascii?Q?/sXHAjXdgvzQtRnGCRuqLvMyWQk5bwM/lfQhnqTZ4QawMx4DrJXzK36TClPV?=
 =?us-ascii?Q?0eoCuvt7MBO3pTdbu5C+m4IEalqlDGp4c0f5x1mJPNSkpc5aq99rw34YySaR?=
 =?us-ascii?Q?BeDDoTS39qdd5GeDnQfBCbIMMhiUQNUU2fU0wM5tr7OLwooGdHfrPe2SSmBY?=
 =?us-ascii?Q?2+lpyWTFsWEeJbA3+YVmmOreA+AjnPJK2vygCyg8A0ZusHZheW64jMzsScVR?=
 =?us-ascii?Q?g87U/AncCQSSjEqGWSsUvhD5iPhnPJHZbv6oYP3UrDhWAPSMN0RcbK4yrfHw?=
 =?us-ascii?Q?6qxWzQG2DV+B8A8mdk3zQbxiebiZn3pdWi87e/1Hy46gOx22AO1f+q1b0xEJ?=
 =?us-ascii?Q?Vgjp2/TaAL1y58oaj7X/ohc8ONxiPR9Kyqs4aCbzBmX4e2TqHObipVp4LHFO?=
 =?us-ascii?Q?SFkUJpND2HQsZq9yC5x4MKwIqSF5zmNUQ8m66LwEKJFnPASgC7kMxT5cdU7u?=
 =?us-ascii?Q?6KUCY1qE+abXZgPmrU32vsznBPvTR/PUDby4hMacfqDeponHg4MijS3uv+V9?=
 =?us-ascii?Q?W6GNLUrjYSKJirL8/IMhLHSpqXJGtuk8jMo/3KW6+Sl5p6p9OJGWSPy5WwHL?=
 =?us-ascii?Q?VpjZaf95vjkDrgfdZt84pCPDXId9/o5y+BG3TF1DXq42/shIviz9TZIj+sGp?=
 =?us-ascii?Q?xJNPrPT5iYYlrLCCzoDoVHOwgXE4oHknrpRzwPqy+KQP1x8Ankfy/hQQrBWu?=
 =?us-ascii?Q?J1X+fYQEgKjz7ip8F7MX1EUnUlkiKG//Vxln5EwqVxpURCmU5AxNMAd552sE?=
 =?us-ascii?Q?j5nZ3J5j6J5KaQb9WBm/nU6CWBAcy0izajWiiWZpnPvUxcAKzyJWzw2qlpWn?=
 =?us-ascii?Q?yoj6+BFlsb4hY2gAM0vbkQKKtWVnXtgBjmJZJh9UZXh1+ImBBiGDwtt3czZD?=
 =?us-ascii?Q?ypcqexvBbQalZjQYoe3ShNAuQRCTVlallr/GmBS/+hBcQfEsiKAH8xjkfgTV?=
 =?us-ascii?Q?b4D2BeNPFIkbHzb/P/yN4+LQIvzzIUCBq/k9hzdNl/0ud6WaQrwfDoHICnc2?=
 =?us-ascii?Q?khzWjJMl+o0YqJNiGyc2AxoETrdW2wOmUVLgUvaM?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9016675f-566b-4dca-d30b-08db83950d65
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:34:00.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkfLK6J6ZAh/GdtfAODaQiMq46x+DM071gpHcLNR/NlDMzhjHdkethELy8ZQmzP4MCXh5pIaJWUL3f2KenXD9A==
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

Adding following function to eventfs to add files:

eventfs_add_top_file() adds the info of top file to
eventfs and dynamically create these files when they
are accessed.

eventfs_add_file() adds the info of nested files
to eventfs and dynamically create these files when
they are accessed.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202305051619.9a469a9a-yujie.liu@intel.com
---
 fs/tracefs/event_inode.c | 84 ++++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |  8 ++++
 2 files changed, 92 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 4e7a8eccaa0b..75dc8953d813 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -215,3 +215,87 @@ struct eventfs_file *eventfs_add_dir(const char *name,
 	mutex_unlock(&eventfs_mutex);
 	return ef;
 }
+
+/**
+ * eventfs_add_top_file - add event top file to list to create later
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @parent: parent dentry for this file.
+ * @data: something that the caller will want to get to later on. The
+ *        inode.i_private pointer will point to this value on the open() call.
+ * @fop: struct file_operations that should be used for this file.
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
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ei->e_top_files);
+	ef->d_parent = parent;
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
+
+/**
+ * eventfs_add_file - add eventfs file to list to create later
+ * @name: the name of the file to create.
+ * @mode: the permission that the file should have.
+ * @ef_parent: parent eventfs_file for this file.
+ * @data: something that the caller will want to get to later on. The
+ *        inode.i_private pointer will point to this value on the open() call.
+ * @fop: struct file_operations that should be used for this file.
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
+
+	if (!ef_parent)
+		return -EINVAL;
+
+	if (!(mode & S_IFMT))
+		mode |= S_IFREG;
+
+	ef = eventfs_prepare_ef(name, mode, fop, NULL, data);
+	if (IS_ERR(ef))
+		return -ENOMEM;
+
+	mutex_lock(&eventfs_mutex);
+	list_add_tail(&ef->list, &ef_parent->ei->e_top_files);
+	ef->d_parent = ef_parent->dentry;
+	mutex_unlock(&eventfs_mutex);
+	return 0;
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 432e5e6f7901..a51312ff803c 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -32,6 +32,14 @@ struct eventfs_file *eventfs_add_subsystem_dir(const char *name,
 struct eventfs_file *eventfs_add_dir(const char *name,
 				     struct eventfs_file *ef_parent);
 
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

