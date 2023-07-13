Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD895751FF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjGMLeH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjGMLeG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:34:06 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011008.outbound.protection.outlook.com [40.93.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EE026BC;
        Thu, 13 Jul 2023 04:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m13SMKFIm8odZGrq72+5EnUB6DWj2kY8VwittwZPieUN78KEv/KthChX27vKPbEIdLRc7KPjxq75ggIuIpLMCK5FheBm9KWejFyH3lp8gbt5Bo/ufhAue/Gge+rNTtw/f7CUQSDcC8XSL2SkVr5qXT8ZqNIQHtIab49l+B/9Q3NslEywsNghljGsGLMuR0Z+NwNtjLhktdTVlkmNMXH41k2BEdZmsPVxNM+gcV10B8GQh8GNY3lLC9Y+gtTtHPvWU8CJY8XyunbaFL8hCNaHZVBF8Z9NEGZhDRHtdczzWh7pSEMssGLyuwuO08fJ3wIQ4s1PKEvONpQxtAN+HyE9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzZTlXeNogJBViXGqA0WhbvwMo1KVjybgLRgYLle9JI=;
 b=fYJwBo+fUHaS+/JSPQX937hOdJtl/AbPUlQnF6CZKbPcsGiHcnTps9OW2/+df3viSgkGWOQSRnOhIEFAMLRFUDmAwzWRPxcavT4RUzXFVg6WSMTUoU5WbhWrhxilpMTjxZkDh19vzbM1iPa5HQ10+8nsH9LTarbr24FeuhsMD74wNV7QjjkcJUPOLi5CuYbXmCoN/XUfTN7lQ+D+ifZjtOTlyIJNPLjqR10l4d5VyeIfqe+omuJQbhn8t+qhtowji3hnem3tFAXfaT6PfwX4vKrZhGNbbsjfdZ1BxbPyspYAjYKHhKv0soH1dSvJMuYnjz8mESygqm+6/rDEdep8GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzZTlXeNogJBViXGqA0WhbvwMo1KVjybgLRgYLle9JI=;
 b=2gxmIQdbpsdgu9i+js16ReYjwKC+2A65D79BN5zIRlO3Ga8HqP3HBPjEch2C95NJAzxR3VaXEMpEt/Gd57QfNU0DxuLuWpOmnbidMwv8fEAdEEgDswwNfhfj91pHSHbh9hgSHMhNWA3f8Ccs1GM5izibiPFHQa3lQvNvpJleQug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by PH0PR05MB8719.namprd05.prod.outlook.com (2603:10b6:510:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Thu, 13 Jul
 2023 11:33:59 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::119b:d975:430c:e1b4%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 11:33:59 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v4 02/10] tracefs: Rename some tracefs function
Date:   Thu, 13 Jul 2023 17:03:16 +0530
Message-Id: <1689248004-8158-3-git-send-email-akaher@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6a311f42-e834-4ab9-0440-08db83950c24
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PklzPtSq9GYm4sdcP5tmARNR3X0XSaopJzDKnDStyPNNqpzPqNdzMoVeoLbLOTVCqOpGYiLHPT+0yPIz45fGlv76yftGEOCbU03AdhuEBWKGJi6ee0NAst0FlfkjXKx5OFpMDv9JJZObRzV6jsWB01Esjz5X5evXM+qiRKuxyAh3aFyGRw3MKSaEB9FS7RutNpAXt7Umy/gqDkCgtR+nWh/3C9jP6IWdxsuczF2NyKOP3ziR6uioQKhAaY0ut42Oh2aSjc09tdLMGXhseiV02f20rhk1lMdAQEFGmdwL+xPSRIPxhDlNacts+/YYdgOgVN1ctAlobQ8u5cJywvkuRwTX08yAkokl9C7pNRPsvWyk5z7kGV8mhxDEOPPj62nuJ42aTpoUhmQyGYP5icRBGJbzTOc/tb3lzGA/WkZdgSWDChWp8jBnDex3lVaaGCwunsOurLDU39OPbdq0qcFNWh/lM9PxJQ7j85wiCIzXMg/8YmB0SHVDVtMc16pZd8cI2dUwjLuOAx2CkYmVDP4ImUFlqpBn42MRVGZ70Wu7UUakfSTJT3qigexWG8VRGEymlkOdCRglTeO2146Pz+V8ZvCikYt42ua+BLYUdoIVYFzkXaSWxlm/IAW+7VY7MGxN/MggTIhoeRKJ2hgDDOi+xw6FZR3N8/RUeqWf7BIjECk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(2616005)(83380400001)(7416002)(2906002)(186003)(36756003)(5660300002)(26005)(38350700002)(8676002)(8936002)(107886003)(316002)(6506007)(66556008)(66476007)(38100700002)(4326008)(66946007)(52116002)(6486002)(86362001)(6512007)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sX/qo7vrMVPG74nMJOotkgjHxJeF8a70/AAJAbbRn1Uhmxe3x4510LeFJd55?=
 =?us-ascii?Q?q/tFyYbisXEYifvVFSxq+IfqEaJE2ydOtlkhOtU8iF1sLu+yGRMN7Sx0h+YE?=
 =?us-ascii?Q?0IbreIkZRIODAR8cWRpbu1RAU5OfXVIJqZwg8WBVFEFYZ6oRIvygYsoQV54l?=
 =?us-ascii?Q?jtLvmIaaKmvO2WaMc2tPzMd+D8m3hc7ZEepO5YCCYBjqdwSZ/E4I4WrUHoIx?=
 =?us-ascii?Q?POEDKctNA+HdO/YaXWYCL3CcBnNxkJiHJ4/DU3scdmIuUDdfChonoLTeGvQ6?=
 =?us-ascii?Q?KwkT//m7TU+fPxKvFtK6auf8BkNPow/TfKeqFoal7A4eFVCoXab36bOO4ZrX?=
 =?us-ascii?Q?UKH71ngtnmpu/6epFRmsAY0/IrZdYRqhiw5Njdk0lp23iKPv6Rar++l5iMyL?=
 =?us-ascii?Q?vIl5IxxipadF0Mu4t/D+SpiGjEx24yjlWyMwd4PwR5/0o/nT7sOGquAsgvuA?=
 =?us-ascii?Q?CFYWFhPfZMX/GCx5C3B1XDBuHDIRESbe5WPnAMaE/w72gSuQDEJw/r4KpbM5?=
 =?us-ascii?Q?w5OJ7B4aobZjm57V5hs8ShpUyA6UdBU40M06CWrQNSJ4pQPri/fBmfatfHTb?=
 =?us-ascii?Q?vDcks2ROJLtYflqa2uyUIrhsbEzEl8TXYD8NU0xOfcsEVxrsozH8BjAHFk0M?=
 =?us-ascii?Q?ave91J3j8DSb6EPf693Z/w9AqDMNZV1PfYqQk68jCshrrYjRvj0iYnCCIH09?=
 =?us-ascii?Q?3RlCN/oXZhQrcvLK2yX4WvfOt6zNy5eYNB1h6FdXt9WaXAotbcW/EwX7LDnz?=
 =?us-ascii?Q?+2eqQA/vzSuGPuKfAh7eqlUX8uYEAYtde2IuLWr6m0Tb7zekpkcJWFIy2gam?=
 =?us-ascii?Q?AaAJ1aXmMmFakh4Mg2CmxnHyO2UW5VDAyBJZz979lfwZOOE+45NYhTfdlLvW?=
 =?us-ascii?Q?h4sast46Kaaht7TpZ6UpKN4WP3zRX/ubhWut/mJP+wv/bdcyDooXTln+PGcO?=
 =?us-ascii?Q?J3S2qjB3f7KgHbNgOgoWUEn+nmh7+yTUbbsUcdOUen+LxhLCKsAgWRiugCPZ?=
 =?us-ascii?Q?Zn77rEkkRDjpUxcqCcLHowYy100CmoGaOcy2OmklVDZrUXTY79szZA9YCx7o?=
 =?us-ascii?Q?Xx6GVnzK8/ZIXcQV5A/obXTQdd1c/raXcCX7Ia2GvxAh5IewPRJBDbyuE26r?=
 =?us-ascii?Q?SZM8Crd7q05UqZ6wXkoFqowbdII391aZMgejQH4wYAyYpbjVS0oRLyH53hKv?=
 =?us-ascii?Q?qC9oPOk2itCEbsBPUsKFalFBJ0cO+73HjE40oh8EVsuXoYrtYMOCeBh9Zn9E?=
 =?us-ascii?Q?08qhd4/dhjDNPMCwmxH0R6S8jCaoDAcTa7a3aKBDQkkgkWvj7abekRVgRLe1?=
 =?us-ascii?Q?0J02aW6BgKx1dVd2esFYdKedjwJit3l5y4xhmcfcUYb1qqKmqqVNvzHswbwd?=
 =?us-ascii?Q?wFnBxxPD8SejYu4pkh0ywvzChygsLQ8qUyeQPsQu/C3bDMVEifyfrpwt7Ihp?=
 =?us-ascii?Q?WcjcuTT/u93Ij2+0WOR2Q4rtGemlfGSCKw8eepW8/0rmarbeUvEzNLezqYBM?=
 =?us-ascii?Q?cGPWfOYa0RQm7sBaaJLFd6UhdBY9EqGVzXO5vtfFTfe1teUTp1jtocqERuUO?=
 =?us-ascii?Q?J+95+nrz/xq6ipNqALrEr0lDNi+5PLUhKcoFeqS7?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a311f42-e834-4ab9-0440-08db83950c24
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:33:58.1594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usDsarGpfb0RqLH9da2mlhqJg3AQv+YTdjDYC0I24zoYIILMByd3sRTbS1egGoTYHK8psjaYKyZW88/lLHEuFg==
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

Renaming following functions as these would require by eventfs
as well:

start_creating -> tracefs_start_creating
failed_creating -> tracefs_failed_creating
end_creating -> tracefs_end_creating

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
---
 fs/tracefs/inode.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 57ac8aa4a724..b0348efc0238 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -399,7 +399,7 @@ static struct file_system_type trace_fs_type = {
 };
 MODULE_ALIAS_FS("tracefs");
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
+static struct dentry *tracefs_start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
 	int error;
@@ -437,7 +437,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 	return dentry;
 }
 
-static struct dentry *failed_creating(struct dentry *dentry)
+static struct dentry *tracefs_failed_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	dput(dentry);
@@ -445,7 +445,7 @@ static struct dentry *failed_creating(struct dentry *dentry)
 	return NULL;
 }
 
-static struct dentry *end_creating(struct dentry *dentry)
+static struct dentry *tracefs_end_creating(struct dentry *dentry)
 {
 	inode_unlock(d_inode(dentry->d_parent));
 	return dentry;
@@ -490,14 +490,14 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
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
@@ -506,13 +506,13 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
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
@@ -520,7 +520,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return failed_creating(dentry);
+		return tracefs_failed_creating(dentry);
 
 	/* Do not set bits for OTH */
 	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUSR| S_IRGRP | S_IXUSR | S_IXGRP;
@@ -534,7 +534,7 @@ static struct dentry *__create_dir(const char *name, struct dentry *parent,
 	d_instantiate(dentry, inode);
 	inc_nlink(d_inode(dentry->d_parent));
 	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return tracefs_end_creating(dentry);
 }
 
 /**
-- 
2.39.0

