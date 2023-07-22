Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E62C75DE49
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 21:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGVTiO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGVTiN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 15:38:13 -0400
Received: from CY4PR02CU007.outbound.protection.outlook.com (mail-westcentralusazon11011013.outbound.protection.outlook.com [40.93.199.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D280FE79;
        Sat, 22 Jul 2023 12:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG8plX16lq8Ze5aJxdb8kHEdWAq8kgW0SRlPTv/Yo3Iq+3+U0XQ357ejVPLZbEfNSW1MGe7qHMr4CKKa5SUeLm6UOHNNzJAX8SriJDNQwj0f0eD8BHdA061yWgMtEgBthO8Acu2Srtnx+n9wv41P5nkPgUGqgeWWburzVPcB/7oZDt2Xh8MQn3NMv8GHXrlw0KWbMWTzcrDgfa88KprfVrR9N8s40y+3TBQYsYQVQvyIFptOFY9WFeLQaV+CazIHuqUVZNT3LOzDmgOTuXhrUXIHyAEpQ4y8wX1mQuKue2uA2HZYmonK30Mv1s52W3thpVGVLWDwt5thRwmVVaiPHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoeI7FrTyh9vJhuPmPvCbdmu7ah/hzsk5uKcYHHd0YI=;
 b=c/L772IJRxM2WCiqIYUFqNoTAQVgkdVfro4ppvbvlYYI9V7q3f55V2Mg3LRJ95zmBhN373SvrcA8qYK94+nClnsZQxNw8+T6xjJnnjLZKNduzD3S7L4ApVoyfuWVCsH1TImHsOyZ5+4agBlo0yJagaTjlEgiwBw2vUej44s+oTV+JH7vOXHvLgPz1kZPg7cbuN/JQNc+/Kc/MNtcMrZmu00Tk1g3odyx4Eryc7CCYF5ZeG3djQmvA1+y4lwoB1Fnmb5cm6Z/2bIpWlwSJE8pZDcbracGhcoRctneXZ4iE+hPHPPgJyOcvKlIW7N37n0bLrmwpjX+c7zSvMIzoZfwSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoeI7FrTyh9vJhuPmPvCbdmu7ah/hzsk5uKcYHHd0YI=;
 b=q5wmRMdbqXEYiHyP+DTYaZDh2cfX9zUTGHxVeEYpYdswbmpodpzzhpB1OaUv3aZMFH6beXFxvKUjU+CtqaZF7P4HmEBrG5xfnRa48GgFScLEmkgIE3R06NTNyuTVWuQtK3WET6ukFJcLbX4rPFfgvx07RgKDykbytsl8RI5x1dQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by MN0PR05MB9005.namprd05.prod.outlook.com (2603:10b6:208:3cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sat, 22 Jul
 2023 19:38:09 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::b5d8:98b9:6ca7:94f0%6]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 19:38:09 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     chinglinyu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        namit@vmware.com, oe-lkp@lists.linux.dev, akaher@vmware.com,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: [PATCH v5 03/10] tracefs: Rename and export some tracefs functions
Date:   Sun, 23 Jul 2023 01:06:58 +0530
Message-Id: <1690054625-31939-4-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690054625-31939-1-git-send-email-akaher@vmware.com>
References: <1690054625-31939-1-git-send-email-akaher@vmware.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::22) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|MN0PR05MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 1430422a-c811-445e-ee8e-08db8aeb2d97
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9osDlDdPNX74jXSHO1YI2r/Pj6TNkSiBfOXx3tZfJcbhbGbBEBS87GM6Eg+D6x++Yfud1YPLObOizwVLEvW0bbyBJevkXaGLE1kovSp19dJQ/nCsSsWQ3YPKoTV+7y1W5QjlrQwO+Bi0RuK3dEqJ+nby1xQMYKEl5hLMjbZnJaZ/R0c8gbFzdAR8QqEpgCEZDJiMB+/9jiklM0p2OHCv4zZu+GA8kDlnOTdnNfnNChUmFjl4szv4WP6TPHeeRF/ShAxSY9fvnCAyj0XW0q5KaK15O+wzTXAKyEvjOQ3o/DaZ8mQayDknNgTTfoF7jXS75wMbPvkmY8jcl1xKxBuKGeRYxeUFZttOK/9k9822lapfFYMKnqhZA9kqLHzy/YdgBXuj50uevwoq4eV9RM7SLga2MdrVZyQWzppJouU1khKJ+7B7eJiaWi7CtJNEQM2cFMzUl9JIjvPWsEsATuCrG14GoYNJGe22+G4ZaDjYOMIoOlOapxYdY/eSKjPG96YNyGHKsI9ogot9AI9e2df+8sz8vhwisGb+86itxn9GTSB0qU97ASPgfVa4HnIFw1zjpSFw8ZG3So/CTIU+pHeYNtFZJbz22VODoL4XsH6fVbbzEf09B4MgiWKB5PBayNZNpxVuFNKA+TrASXqQEGaSDc4VE1oTcUXs33WmpjwgMmE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(6666004)(52116002)(6486002)(6512007)(478600001)(186003)(2616005)(6506007)(26005)(107886003)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(4326008)(5660300002)(7416002)(8676002)(8936002)(38350700002)(38100700002)(36756003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJ7yFE+0e3lqwaFZauatECpGc5/Mjh3CxUTK4bd4kHDhu0wrxsEaoSSLgO3D?=
 =?us-ascii?Q?0EW79XK0kKEbwCtVhSB8a/mny4dJu24kNpnkeJss4RMw6aijEY106dhs1KuG?=
 =?us-ascii?Q?ZA7YksVEhp05CBzJ5oSFNfCCyRV6qtx8MYFaRoZubXDjZErO/gIKDnM88QI0?=
 =?us-ascii?Q?1pUIQ5HyzHQD//fCAwBqgNIbR+eGAWsanaOoczlo6fftaVygmGhP0iqTnWqf?=
 =?us-ascii?Q?BHsLn1Oel+IksiXwfTTRjdrHFeS9kPIGv4MGagF8S2TddKyeZmKQAYUXU8Lb?=
 =?us-ascii?Q?gzmsL1Nhb9mJDAE0nyOeaMdCVcFJRFxP1jhLMarbUe1RcrVZJupKo7hDPXHI?=
 =?us-ascii?Q?zW1SAwhZ18ZSkWF0FO0n3mfI5Z/vKaSHW9ShxQZk4bf2EyI6UpnUsd5hy/fm?=
 =?us-ascii?Q?gzo8QGMRnRNmHWhQpERPPiJxMd8KDK8kJWFRO0HKKHEpe4k0bdWoHTMNvSLr?=
 =?us-ascii?Q?2wKzJy9vJsyUYl/mIIQ3fkFgy7GaLyDvTO+giuwedZpIZJTOgzluDJe3+Sux?=
 =?us-ascii?Q?6GLhRFs+a8hAQ/xto3wcXZsGyCP5hWFKwttA/bdlyNHYfwaF+5DhQ8zVJzYS?=
 =?us-ascii?Q?MJDM7Ue0F9yxevfb/hpOPDTSD+YDcXuIEEPSCwlq4MBX942QarVT8WUbgQ0p?=
 =?us-ascii?Q?csYyrq47sH3C7iwWSccreHk7IGmAiGsOAEcjn3gAqsX4mM3LowM2oeR+PAsC?=
 =?us-ascii?Q?VDh39ImZG6Pe6d6JUXOyOmPoSsb3/yqGgwtHzy4Xjvs7L6JVAWKJQ3iT/3/U?=
 =?us-ascii?Q?Ii7R5TRTT+wv1sxB8DSat23/dLJ4xKS3bUHnhgBrBDZ1Vojk8cLSxFhgfSBy?=
 =?us-ascii?Q?iurXzHPuPabgv8+2SuGSbjJ9OOexe0rX8muFy8x1KB9+y9LnX97KI7MfNOYD?=
 =?us-ascii?Q?Wj9xTC6jlFx4lGNjySkZvQ/EffOyhsQoxUVIuGsJLhUUzbub9KDtGTg9hI/r?=
 =?us-ascii?Q?/Ykx41lK7lJEOmEMEta8Nt7YlpoMeP+F9MHLTJ7KQS+cHxJsl2VbHIxxa5Ee?=
 =?us-ascii?Q?F9b7lhH91ZsiWao/0c6GMFeQfmfgbCfic1MSeZxGawLPs+t0NEwScbJO/9pp?=
 =?us-ascii?Q?2wzJ2ovv+uG4Q9IJVuUAF1Dl3ODAzL+O8Eg2VredjqQgi2Cud9YnyRQGnBzh?=
 =?us-ascii?Q?ZMvW01r6cwbaB8YwJsXtFFntjMtAHPi7HYRacdYoBKwuRXbW46aPwnL6tqRW?=
 =?us-ascii?Q?MCkb2zppBak1FN9Syu4eTdCvkrqXd/HWgf3gsomU6HoWYtqlVlCbh/GKEsuz?=
 =?us-ascii?Q?VrRTkr1OlBqHRldDD7bU0CHS1pdBIjtlvKUZS2n0lSXfR4rzo3cHkiCnIjZh?=
 =?us-ascii?Q?LSyJdPCyhSNCJwqCFZOIt1zrHH9wRnNCkyaW9GyrUVWKPVRJkZAznBU0o91I?=
 =?us-ascii?Q?BdOSEXzY3jn2uqQfogksJa5pwSPMSIbWOi2+HnEMK9K5z2KZEymp3EEPi09a?=
 =?us-ascii?Q?xA1OhxMv/lfAFCCwqjaQRUQfz5pKCkByRxxTjrwA5BpxClUlEXmLqtr6HCm0?=
 =?us-ascii?Q?fXJH/xnX3RnumB/NVMRd2aqvSotVyON2y42UrgPuNRqaiQoURrNB/mqem9Yc?=
 =?us-ascii?Q?V7jVvLlTznm48wjHlHNS+Fc66Q3RE4u+LZi3fQ2I?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1430422a-c811-445e-ee8e-08db8aeb2d97
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 19:38:09.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5XVemESx04p9EQ1wd2dbArIs6fH8IpWMWnfOY4JuLCoGPSHLQoMojcwJWVP4x9b8UHFR72wDzqw2apC0wC5ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR05MB9005
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
index 49b5e8949e1c..f0fd565d59ec 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -16,4 +16,9 @@ static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
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

