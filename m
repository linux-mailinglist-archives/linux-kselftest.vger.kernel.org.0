Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB3A70685E
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 14:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjEQMlK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 08:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjEQMlJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 08:41:09 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012007.outbound.protection.outlook.com [52.101.63.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7862102;
        Wed, 17 May 2023 05:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZkGaTAvHMhozi3DhmzEK36drFBrZnJt/mhXvNDMPbRBCBztEMqfSvwyaHskPnVRkvc46KaJuqkxJO0MSqbps+KsWPqPb5CyMyg02ohF23+zlD0aKyaJmsEIi1RUTm5zDW0nhTuz6Sx+14XtKbxrWmwT0NulITiI3PpH77KdCWNE/lmjzPtPfcFhlHZ3oQ3KX1pYoc3jj4fUCvgdA/0rAVXFB6VexEvrj1goNQpzL+FsrgZ6mOXS8ef1rYYut/hW4yFIzrKLtjxsVZcbX8JwtyHHN117Wm0pvJ7MiSA3wbvgfV3UpuOlzbu0ZZI9lEEYZDr6oaHSRgVoSwXHD6xS9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGE2F0xCFI851yDYlGsYBTTVnJCXNvv9EoD+tfrKcLA=;
 b=YCZmhlFmFH6g1D593iXnusUudiJcQpKkfGcTVjtWIZvEt58L2f6ce6fAWeQ67kQtQciFsbatOdLRw7nW5x9PXyQPePHGpcpHCwkdQBn49Gnn0oYZu3k5Aj7Fnb0ZbYNomc1ID0czb5GDRTgrihS5FTRTekoRIq6jX59hG4P3C3N9ZlxG7WH68wbZv/mzymV6h4mYbAjHmlGzmfTlXI3fkv++5KD5evAeUAjgYpPsE/BDNxvCY0lmdpwhKcQksbtCMtgU3Lm5GQbTPhktOnKV4H9/Kd8YT38JYAhKH8d2Z9EWxIDTU0qse2nwMUCYvX4g0XaPw2eurz+Wl+bbj+8yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGE2F0xCFI851yDYlGsYBTTVnJCXNvv9EoD+tfrKcLA=;
 b=hBjO55LNyjqmmQhe299HftizppW8j2iCFP4HjecM4N2aI/yJokeCTQjuTZec6rCRNASQJD8pTxmik+0690Radk8Ln3DIOQv+geZu3O6HswerpOn2tl/guN2st56Ih1Kb/uBOTg43yGAjUht93k+XEL16uk49hxNgrSpG2WKaV9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by DM6PR05MB7100.namprd05.prod.outlook.com (2603:10b6:5:201::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 12:41:00 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::5631:475a:58d4:cf66%6]) with mapi id 15.20.6387.030; Wed, 17 May 2023
 12:41:00 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     yujie.liu@intel.com
Cc:     akaher@vmware.com, amakhalov@vmware.com, chinglinyu@google.com,
        er.ajay.kaher@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        mhiramat@kernel.org, namit@vmware.com, oe-lkp@lists.linux.dev,
        rostedt@goodmis.org, shuah@kernel.org, srivatsa@csail.mit.edu,
        srivatsab@vmware.com, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Date:   Wed, 17 May 2023 18:10:07 +0530
Message-Id: <1684327207-19817-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <202305051619.9a469a9a-yujie.liu@intel.com>
References: <202305051619.9a469a9a-yujie.liu@intel.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:a03:117::16) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|DM6PR05MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c09c434-e7ba-4588-2f6d-08db56d3f807
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G3liRa7U8M/IljwcuBgCZV1Ksv0nRR/CKtzOBaqCoCMTxONb50fqFSc/flLhwTKeQX6Su+VEDd/Yuwk+jtBU/Sq/1M/Y69EQjTjQkRYIjN9mI0z5+vaOIi1uMOl9OsuawXm2msZ4bVX7xaxJVia7CvgbHzQtlSx957yOSuqJg5siasZ73WJenHZGwu6SBckuq0JRJ/Ne1uyYRN2uIQoXDTkTHT32n/jh1p2WximKx6XKDPZItz0+T/CLUGoHVozv8WN1elThPC/JSVYKkGyKJ+1bvq+cY4PEjIwOknZLYFxDH9nJHiuRahwcJcbYUKOFuA1ruorDlKO64rTvEqtvPxz4MTl8GZQw8T7TcGGaQhHhJFHXdrUa+ZtmALpDdAxR0DZV8re/r2+rk5zVscBn+k10h5lbIZNOM96z0VhWjpPnKLrqogfxOXt1RY0WsCB0D7OVqp2asK5SSh9F4dRdC5Gak54rvzTCOmqF9RM6lb8h6KoJiY6ZyCSyyADYi4XKuGpt/8nRn5l57TQBIC2sCdQn9HNP3Nf27Fn8aFx3PfwZaIcBUL08G8Pr4nW1kS8r/49zE/e8+L/QoXLua5d22J6YuhrVfsDp9dVtlVFhd/p912FkXl/3/H4d1fkl2GuAVE4mhpezerCEmKC10RPusn0Nb6f8FiIzRm5dTf16i81wkC6cKiWJNkoE9NFu0Qy66iGRTqJd9laoJ273f/rN/vMc4Y++MOw4iexqywkME8fR0WHVN6pH62PpSxbb0xW4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(83380400001)(966005)(52116002)(478600001)(6486002)(2616005)(6512007)(6506007)(26005)(186003)(107886003)(2906002)(8936002)(8676002)(7416002)(5660300002)(36756003)(41300700001)(6916009)(38350700002)(38100700002)(4326008)(66476007)(66556008)(66946007)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xLXSeKd1VZhUOYw6rYJ9+7w+JT7xwgkT7QYPeNRW2GwDmbxTl1j0jvx793+F?=
 =?us-ascii?Q?CyK4vDxo3b7JveGOt84SpuYjCchNK20c7iTeoq7W5prS7TH3zgO/ro/wf/dD?=
 =?us-ascii?Q?AT9HaxDRiosMnO9vsbSi9Zgam7BqfAtKpv8FjZrZX/pHFQC6ZTVtrcSlUqXx?=
 =?us-ascii?Q?ht8OX3uJOAFD0l167HfFgTisSAcDct7FmoibkzcIN7Ipdu/MC8Qs0D7SIeXQ?=
 =?us-ascii?Q?RghS8DTD0+KD3tvD7/l7U5voDLcSC6A15m+RcUiuXVLzM4lIXToslMf+0na9?=
 =?us-ascii?Q?PVp3T9JBcESh2wwcP5C7xGUoqyx8OHhXzAiGMOE5oM0GoHKQwHmwPgs9so6m?=
 =?us-ascii?Q?UgnCJlVBeE4LvbfptSKYKUJVHahMX1KVK46vCdPiwkcpJbRpxlH4OrPn9mO/?=
 =?us-ascii?Q?YXEvcRD7cSXcmg5fs5qiiqPi3UfZvFhccUZ4ITmBXwRTTCkmMG1MDKVYKtC4?=
 =?us-ascii?Q?+zdFxX8w0dgT4BXQD3YcO1Jdj42idmc8tGNUOyBMWt7Z4jQuKwiz05h+wGYJ?=
 =?us-ascii?Q?U8asRhHEAgBS27C1MRUvKXzSFZqyUpraaYuYxy34dpc/LM2x92mhGrQ8Q7NW?=
 =?us-ascii?Q?4+QGOFQLXFjUqLZpr5tUA4ZTSDy4fp1MgSrfcWPBYNGW5YgAt/HODBlOh/NR?=
 =?us-ascii?Q?RdD9KZ+94EvqGQmWIgAAGUvYzZ6C6FY8ujVWladf4IkHHJhRPIAz/Po34oHz?=
 =?us-ascii?Q?QKWsRBCAg+XwsYdV9xXcbfOBSBnIOijIx0LCkRZS9NMwJroP83+PkdnGk/UJ?=
 =?us-ascii?Q?ftpTERY69bh7gO3tpYTy72ZYAA2x+sSHi+IiKWFuBe/MczDnUakV8e/Qky5N?=
 =?us-ascii?Q?5fz2eX0s2Ct0EeMQzqVUYP8atGD+T+nbctYRE+7aUgYq2OpWAtgDXdJs5CRB?=
 =?us-ascii?Q?5AJ4UL0vEWsugp/o/lqNUI4R8kgmE9XLXJTwfW1voam/f9a8FHN29dSZN9qz?=
 =?us-ascii?Q?+rFIncFiJamHu4cBYSgjmvtKH6D6Zb5nUhJQ+ssUdl18KLaZfd11zNaGQ4Xd?=
 =?us-ascii?Q?aIc5wy80feWNercPOu5HbgFPx9zmTRZr8apOd7Im3ydRXcR811irNH/mkPX/?=
 =?us-ascii?Q?1iqvexrSryRiv6tvaWvKMpZufWj/ab0wPJjFqPXCZuRArI6W9ybhYPRZOnSc?=
 =?us-ascii?Q?uwWIQfG9tSo8sTlqfS3P5bUB/YoUrLumfwpLHIJmmztBjdPSz1GPC9lIbM2/?=
 =?us-ascii?Q?ZiEhCjblXSoq6cv+qZAJdghuCcphRxgsBL+SaL8odbxU0OC12BEsZIV1kKPd?=
 =?us-ascii?Q?JCqIhz1fPxnPMsVUX2jLsByJk+yMlEAM/CNchH9zG+qVcziL9zVyjvipQwQS?=
 =?us-ascii?Q?WC7rMiUNT728U0sbWj9LTmGPtTkic/gfhvIEEqPQyJpB5TzCOw+JtdJ+TlGz?=
 =?us-ascii?Q?KZWUPqK5AS+ovwsqv27DmVAEktra45XJ9fEzqipMBT0u/bnkfiI4FQ/Ku5Sm?=
 =?us-ascii?Q?iPW0tnne641HmPLdzWOiFgzcwbn7etKzDUoVczO9fQfse56B379GAlYGSAlD?=
 =?us-ascii?Q?n2DOcc45k1/pd3lVtT0DrTgHEneS4JYTN2HAX4YYdgXm4zZkKzdEZUD+UD8E?=
 =?us-ascii?Q?C9ZL/Bf7sYwqNwn58rsEsLy6LHsfNZ4e9oG7QoAk?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c09c434-e7ba-4588-2f6d-08db56d3f807
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 12:41:00.4978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUMxzNnNf1fvwnab6q7ZTFDo7kSoChpWYc1tYGoYqpdNmUK1kCJS6rB8khixg8ZE48cUIEm6oSwOa2j7YLy3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB7100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> kernel test robot noticed "WARNING:at_fs/namei.c:#lookup_one_len" on:
>
> commit: 2fe2002efb23a715f5eb7a58891ff85f4e37b084 ("[PATCH v2 8/9] eventfs: moving tracing/events to eventfs")
> url: https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/eventfs-introducing-struct-tracefs_inode/20230502-192949
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> patch link: https://lore.kernel.org/all/1683026600-13485-9-git-send-email-akaher@vmware.com/
> patch subject: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
.
.
.
>  49.752082][ T5878] eventfs_start_creating (fs/tracefs/inode.c:519) 
> [ 49.757416][ T5878] eventfs_create_dir (fs/tracefs/event_inode.c:187 (discriminator 3)) 
> [ 49.762488][ T5878] eventfs_root_lookup (fs/tracefs/event_inode.c:291) 
> [ 49.767637][ T5878] __lookup_slow (fs/namei.c:1686) 
> [ 49.772268][ T5878] walk_component (include/linux/fs.h:773 fs/namei.c:1704 fs/namei.c:1994) 
> [ 49.777016][ T5878] link_path_walk+0x24e/0x3b0 
> [ 49.783462][ T5878] ? path_init (fs/namei.c:2387) 
> [ 49.788021][ T5878] path_openat (fs/namei.c:3711) 
> [ 49.792463][ T5878] do_filp_open (fs/namei.c:3742) 
> [ 49.797021][ T5878] ? __check_object_size (mm/memremap.c:107 mm/memremap.c:144) 
> [ 49.803055][ T5878] do_sys_openat2 (fs/open.c:1348) 
> [ 49.807740][ T5878] __x64_sys_openat (fs/open.c:1375) 
> [ 49.812512][ T5878] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80) 
> [ 49.817068][ T5878] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
> [   49.823092][ T5878] RIP: 0033:0x7fcddb3b84e7

Steve, locally I have reproduced this issue using:
    lkp run job-cpu-100%-uprobe-60s.yaml

And also fixed, I will include this fix as well in v3.

Thanks to lkp, kernel test robot <yujie.liu@intel.com>.

-Ajay

