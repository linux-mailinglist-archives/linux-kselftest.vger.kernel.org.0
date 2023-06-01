Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF918719641
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 11:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjFAJCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 05:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjFAJBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 05:01:45 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B071B1;
        Thu,  1 Jun 2023 02:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CywL3W1MzQD1XuUEq/01P99dh0+4rjdsr4Tej9OQcpUWj1mPv9700z1ENIe1lp1gr1feROxFAaLW+5PM7drNGtnjYMaDGmLyymate1AebzdSLGR4XjIhtO62ZyPzYrmrtQtZ7MXhir4oNeuztm1nSQt1UeqbUSjHuwFKy9Ql+BJyumRqLpZjMaVCpF3e4f9Eq5uObx0KBY1r3LYWfECo/5tewdHtfbH5Xhz9uWHcSsWc04acTlWaRBQySMYIDRvNHS89VMB9uMXDC4LswB7kwK2kSCWZDso6cc93tEYEYxM80KYWkryuzM70zLSyv4phzZJY8rlXJWafGO9mhYKuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E78sHVMuJgL/uvkdKsj0OxCePCjMkWbxoP7TeuJQJos=;
 b=MbQLxrLCoMXS0oDNyCzACWXmhHDYqoO1yW2/l6Kbhz3PBwVzg8Wfm7Z8I1U6BhODsVSeq0ODZmL+hjNI+iXFRYHdDWVyEi7vR11VLGfuoUO8RwvCkB3FYlUB1JgpQE7ngK5XJCYr1mAQU8L/d5oAh03zg89tNnypp/VmoLGx9dYUKqZ2wJJypgfyhg5i/air2CEo8MtcyNXFjB8F5LLO9e0sdlsu6zUILR5NKJYoCRGU0jjvwfHz9hCT7++OQPfPFmHEGsb32w8kYl7OJjegFeOjKiFTonriACHvTUU946X9hBZKZxyfY/hz1ryJzJIhRMaweyLrTqckhNXAld70Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E78sHVMuJgL/uvkdKsj0OxCePCjMkWbxoP7TeuJQJos=;
 b=R3+L+73GJy0hE/AqArU1SdMu/6E/o1w3B1xwMRk+pkiyitj5r/oSMeOC7BSaOhTi6keEdCxiIrIO6xdg/BzIaXkte7VDvN8xLbTV8Vq+qAybcW2OyrgD9h2xkUMs1gum8dRSkxoW8lBcmxKBnrqR8w+BuAeQqeWKBwVXFDEazFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MW4PR05MB8617.namprd05.prod.outlook.com (2603:10b6:303:120::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 09:01:12 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 09:01:12 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, chinglinyu@google.com,
        namit@vmware.com, srivatsa@csail.mit.edu, amakhalov@vmware.com,
        vsirnapalli@vmware.com, tkundu@vmware.com, er.ajay.kaher@gmail.com,
        Ajay Kaher <akaher@vmware.com>
Subject: [PATCH v3 07/10] eventfs: adding eventfs lookup, read, open functions
Date:   Thu,  1 Jun 2023 14:30:10 +0530
Message-Id: <1685610013-33478-8-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1685610013-33478-1-git-send-email-akaher@vmware.com>
References: <1685610013-33478-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::6) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MW4PR05MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: ed553601-7d7b-47ca-65cd-08db627ebf7a
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIW7/wLL4e+L62533626wvFkWQJ3WizpR4rVZooKAMi3b3RZ2X78JhrFbhpT6NR6jRIowuvb4VLtOr6/WFqeAnNO3iuliwkib4FucGYHNZHfn1jRwVnLC+d3k+LFFSyp9KWWwM9vdrF0DfzKGT1+Iu3PlZziJiixKWzeAEYt4xbtpAWP7ur6co7ut5tzy3Ujh4WonelFe1qavJjEAVcbtNl5ii3NM9FiTmEKDBN6nlOIaiU82+Aw1W81xsToMfb3+VKEJuNSRWSSGHjjA8FmZTHtEW7VjdrghBN3yWemlURIXGA5tgSWr42tJjVpiV/Hf3C9WfOo4w/on2ScjrpQ0eMWBGBVhMwxAhjo1GhiBDcpwaSF6bnGcN5pFs9leurgLpxSOECj3EOUn6QkQkT7pElCkGpO6pS0ABB1g2zqBtQ7Fk0G+AHLG6ZpWnBpRZ++DsvNl4MIfpQ4u+smHIXO7RWY4QkkpaQ42yjfhCS+QqGuf/a5DqzL3jRWnx6jmL0p9usAokPhAgW7/utTcylC94FUKMOVCXOcf5SLhmnA2BmpZZqJYf+YMagcjEZ/ArSa3AAeeiVRMhf4p4LnDl4NVZ84vs/w5C1pCJXmWmXiOAjNZmGAbR1miJu8wBzWSkVy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(52116002)(6486002)(186003)(5660300002)(41300700001)(107886003)(36756003)(8676002)(38100700002)(8936002)(26005)(6506007)(38350700002)(83380400001)(4326008)(66946007)(2906002)(66556008)(478600001)(66476007)(2616005)(6512007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kITzowLn0c02PREQt1SjMxgzdn+W2gGmyZ+JKpinpiehdcWPCBdM4JDHhTh0?=
 =?us-ascii?Q?sId8TcTVD8/FLkcmyZgh6p5kWpHBxWqTRijBUCQDU6HHeQxRrlLQv6wM58wL?=
 =?us-ascii?Q?ozCiWlggu87xFOt9CVqECVn0Y3oY9q0buj5Kh4pOZKaMGDUfCIYomX0EyGF1?=
 =?us-ascii?Q?bch4Z8asReBxPLLAUhD2IBD8HIPo479p0PUwhpvr5a6xaAWtbZYkhbEz5RYv?=
 =?us-ascii?Q?3ClRtcylAR/+q6lAWrDhBYYxwqQkuleJTMinpF0QIqGxTbK0c2YfcAQL/QQs?=
 =?us-ascii?Q?DDcDTYFncrBdfqYS/yy+E+q9PLB1nXRPx7Bd6ft5mS7py44DzJEDY6MjAZ8E?=
 =?us-ascii?Q?KzP4w3beGItP13/S2fJ53/5iDC5dZhNQRlQmT6dDo2fDulowKHdYtc+dwEnu?=
 =?us-ascii?Q?P+O+JY9Kd4alPE31sVMD/GUMpdaD8JUsCaVQUy98pE5gQ4QsZX3N5cnv2voL?=
 =?us-ascii?Q?2T+6a3yAiYu9FxulKOuOLoW65bDJWA8XGUfJouVDI1J6C5WGx44GE24BM0T8?=
 =?us-ascii?Q?QVBy2H0omwvbfie3wGGO+GFR6ZxFsCdc6+WbQfzuFQHN4zR5SmACBSuNZPKA?=
 =?us-ascii?Q?rJWVfXT4mo5HANgwqNuf8H/10DrDOQzZ9/0Z+xz8D+wkkygZMu1icfPAFicr?=
 =?us-ascii?Q?UN4Cp6r4KiHpIHdvBHQvWX5q0149wDKKPMzIL2twMyNGOVty130cNKDS2nf+?=
 =?us-ascii?Q?z9ycTigHSFa+Dm3E7u2kXt3PmkbMI00CK644ZoP8NhoDAYWLDTZAC7jr8w14?=
 =?us-ascii?Q?s4D0lPWo9osXoU/FmQEIJUA+UeuMvf+9PIeWwbP2mAYJj/k73aBAKcbPGq2Y?=
 =?us-ascii?Q?C09wSai4idwkPWYLqmraysvZrJvviURB3ZTr7Ic3GJX9pOreUgKjdOwIdd/P?=
 =?us-ascii?Q?cmOtqH3iml3hQI1sqib5wG2JwgjCLBNsxFY1CUr+57nO6XwUqazbC59bcS+W?=
 =?us-ascii?Q?aO4ccKYtpFJIw0UZhMCcOiS2tqLA78sFp99LTzj+CcaRVrO7gR5REZrR+yoN?=
 =?us-ascii?Q?EoxzmYYIs49roHOOXEL4HjfXntLSNCGK9Y0uuBB9vPmKlaEpLJuwGu8x5cts?=
 =?us-ascii?Q?1vdIISdsVQwrVZ+UZAOBqJscKldANi+Bo0kvMU1zp0lJjPR5NTXvZowLcdpq?=
 =?us-ascii?Q?ggyPAParUjMJe/etJhhn847g3sFlxV/Lra46zOojgzAdjpdrh9T+wfGlSTeJ?=
 =?us-ascii?Q?fyE6TEkwdQMyiAsoa199wQ2vdpRpWdnThjGJ5P7/Dthj11sYLnIOB8BnbwYF?=
 =?us-ascii?Q?yPNYCNm8QZc0Jor/MiFT//ZXWZadCsV9QZ3Uewmyn9+Si2HOGqnCLF1i3s+u?=
 =?us-ascii?Q?q/Z970ndiCxAohvCOdWiEuvToUG1+jIFnYasnanh0zaovjAs+ueavIw+VtSl?=
 =?us-ascii?Q?5hIIt7yE6dlNpNT5OLPL9mR1OjZVfaDvpKdAhy8fRO8BNXkglZ5HXlKjZPDa?=
 =?us-ascii?Q?4avX3Iur1YCQTdc1shfvNmjaokz7LBJGRGGkEzsdkZeUDJJ2sny0r2xaZIhE?=
 =?us-ascii?Q?oYMxjo98Sk2VcCDOSgRmWo00V0SXNY05RLRKOmGteyenAZB7m4TwGys/3gNJ?=
 =?us-ascii?Q?qVgSo3aWqNv8GyIS/HvFWYkheJNrBL+qiFrRIsGs?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed553601-7d7b-47ca-65cd-08db627ebf7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 09:01:12.2518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNliiiRiOuMh5HKdvy+DlVfqT6iJBDghu9r333YExM+itv6qCkizV1CbGZsttjB8P27ewQS4fft4C+tyUKVTiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8617
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adding following inode_operations, file_operations and helper functions to
eventfs:
dcache_dir_open_wrapper()
eventfs_root_lookup()
eventfs_release()
eventfs_set_ef_status_free()
eventfs_post_create_dir()

inode_operations, file_operations will be called from vfs.

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/event_inode.c | 188 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   2 +
 2 files changed, 190 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0ac1913cf..d98ded15d 100644
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
2.40.0

