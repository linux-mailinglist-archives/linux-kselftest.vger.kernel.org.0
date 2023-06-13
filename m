Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8AD72DA78
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjFMHKo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbjFMHJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 03:09:07 -0400
Received: from CO1PR02CU002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F7E1FCF;
        Tue, 13 Jun 2023 00:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6geNLCCtpcOgToKe5FwvmoJz7Qyqr77qtOZZJcEN/Og7GktuSzpRQRoQiYK30ma5Bq3AVQOOac/e8EdEFQcC/a1ndUgSrG7gjrN9G73lAQCeFOu0LKkZ4u4MZg0U9KX1T4Q8XsPWlMLZzQCk5fmcsS/9NQd1zBEPJhAzDZkasGJKGSmIWpaueFJH/XiqTOwYbQdEDNz9A1au4guVtEZryCPGklnQUy/+6H/TthGlpVBxzW7LnfbpRk7aZlVui1/U6aJ0RD3U9xp/3V+BoyDmAbR7dAyM2ui+omZZGlyTLEwoo+4OnFjQfWXzvAAv35HcUERgwrMFyCNWBizBp8ugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2T46ayk/KmwMZw45gKkOA58dpE5dqcLAdSxSgf0hqo=;
 b=Zd0g0pf0+wN1fUvshb3K8tUfAJ+R21rEB2F/t/BWmYS6zcbJqaOalgVeA+wZ9OIi3DbwERfAbRCseu+mnaLjEhildZDGLWEUuogbHm9+gZ/3TtMQTw363XspmRg0jw89n/9fOn9Jzjxjt7WX03d9AnqM+K5zuNLdd2mO6wva2SMkaELRjYeISF+jGGk4zQwBzDyhRN5UJJOwP93SCFhmcsOl9wHrup5x+bZLvQf2iibwUo2FPIYyvhUzsZeIrSQjvYoEJwk/6mVn22+pC6IysJ7L9rxKq6hdCZRlXEfBdlrOUDn7NM+B7Br6ZiYOOCz23tuAm5MglbR/eFRxiaILdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2T46ayk/KmwMZw45gKkOA58dpE5dqcLAdSxSgf0hqo=;
 b=UNMxzuqbl9rdZULq3YDRtMHETwfY2WEkidsTpmo0m+DZNrIh6PIQJA0fSmH80KRRkIyrbrMEPpgevL2v7DfddfLkTuXD0rKQzp9jBnKmFKNpx0ewGUjJ6Jhpo3kQmlRyx4yh/tbJhBs5C6rZCmz/4UeBxGUTiFowTyBHJ1ft0Io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from PH0PR05MB8703.namprd05.prod.outlook.com (2603:10b6:510:bd::5)
 by SJ0PR05MB7643.namprd05.prod.outlook.com (2603:10b6:a03:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 07:08:21 +0000
Received: from PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044]) by PH0PR05MB8703.namprd05.prod.outlook.com
 ([fe80::4f1a:ecac:2dab:7044%3]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 07:08:21 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     oliver.sang@intel.com
Cc:     akaher@vmware.com, amakhalov@vmware.com, chinglinyu@google.com,
        er.ajay.kaher@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, lkp@intel.com,
        mhiramat@kernel.org, namit@vmware.com, oe-lkp@lists.linux.dev,
        rostedt@goodmis.org, shuah@kernel.org, srivatsa@csail.mit.edu,
        tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH v3 09/10] eventfs: moving tracing/events to eventfs
Date:   Tue, 13 Jun 2023 12:36:44 +0530
Message-Id: <1686640004-47546-1-git-send-email-akaher@vmware.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <202306102230.b5aa258d-oliver.sang@intel.com>
References: <202306102230.b5aa258d-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::8) To PH0PR05MB8703.namprd05.prod.outlook.com
 (2603:10b6:510:bd::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR05MB8703:EE_|SJ0PR05MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: b0cede16-9e55-47b3-b726-08db6bdcf8bd
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcnX8vDcf8CukPVf78HNbwTy2gQqITU/MjU18S8Ddby1bp1h2VMSfDIYuKYkIu1AVGjnl6PUyz1kQHR5bqnnhGLrrcmDbvrV7kLW8+2729v7WqHJIWwCL5tj5B087Vlwr22vShv2PD0ozSqs8pMbYMGrzlDZIQ22MBIwJQV7VveMVHPCFhM/kislgAmVlV7d3hzS6qumlJ49dlhV0rczGujlUWSJbMiVqV6/+dQQ95aY5Nx060AqlBRfYy3YFEYSG+Nm9ztzjCHmqROi+lzm32Hy9eUerfeFa4YUi8oJVX4+9BEbPc0e6imhz0wjxnZcYTYUgwq1lEhPwxFoOtYY3n/TOXWYov1IWe+78eIRvCnT0+S27EKELbdyGF1qQisV+29BBZbinis0qJwi65LkSR0Ers1wA9iGPRQ47P2rOQWfGtgPacH359FsA74UyoC5qbCzWPkaxHPhFXP4aMDTMLJ7VbxhRiBboRf0R2htybK9Kn7LfbMus20eIuY4n0VEPkbU6a5KC711H39PYG06YCPKxdlBeCXlumv2wOvXvMeEjNDsPZSwjL9BtW/yqWQT6O1a00PppJGRdYKKVzXT3h8B86XjJthxAI6FcRg86L8O8OFwCxhunO9u/klQM/cxPjDT+DPZFqDggRQcPbap6bg91VEITOUfauDe2/Jao199G4nLHpMbkfCSQpVDwfudILS0RDx+mGviDmyaqHLG0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR05MB8703.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199021)(5660300002)(52116002)(7416002)(8936002)(8676002)(2906002)(66556008)(66946007)(66476007)(6666004)(966005)(6486002)(4326008)(107886003)(26005)(6512007)(6506007)(186003)(316002)(41300700001)(6916009)(83380400001)(2616005)(478600001)(36756003)(38100700002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVqYnFMQUFXV241NWpqODQwaVFuRTVkNktRN3dLdEh3RmVOMURaRU1lREdP?=
 =?utf-8?B?YmFYR1pPbXQ3U1grckMzelNrMGdtaDdsMGhBU3BBZmM5S3JzWlRIZDZibkJ5?=
 =?utf-8?B?YUh0VnErejZoSUNYYTg4bVArWGg4QmlzT1hkZWttNy91bVJWUnhESjlhOXNH?=
 =?utf-8?B?TUErbzc3YzJoUmV3NHkvdlJUclllcTJSUXZDVGE1c1JJd2lHczArekR2aDZR?=
 =?utf-8?B?bFV6bkFndGZ1TEV6TVp2eU12WCtta3Y0WHFBcUlJWTZ0eWt1V0xVb0xpelBT?=
 =?utf-8?B?UktVOElzcW1QR2dLYkZTWDBWeEl1SDRqcGEwYUhjL052OFhWMjlTbzRzbjRJ?=
 =?utf-8?B?aHlONkExMHVhTHRPci9OMkQzZnh6TGUrdG9LYW5ma0U5RitwYitIWXAwTjEx?=
 =?utf-8?B?NnczcjZUR0hQZFV4UnE0NjRGUEdEam00SS9NOUxab2xvK2UzQWVXZ3hxL0JZ?=
 =?utf-8?B?Z3lLRXRGTWdueUpHN1FRcFpTdGRocUh3M0wwR3lxN1NLTWVWRW9nVHNSNDZT?=
 =?utf-8?B?bHA2bm5NTG42a0wyd0p1ZWl5RHc5WU5VZ3UwWjdOUHJaQW1kUmNjK1E0MGR5?=
 =?utf-8?B?MzhLSlhWa2ppZk15RHhrNnl6N3ZFQmFVd2Y3dUlFc0JsRkdCVFdScEpPRzgx?=
 =?utf-8?B?MkFza1EzNE9lTXZIcnNGTVpzb1V3cUZaMzFyTGVwdlNtVXZnZzc5eDVHRTNi?=
 =?utf-8?B?MjFsMHgzeXRpYVdodzVGWFNBYlFLZEJhclFxZS81TGJwZThKTzlxdE9NUUNo?=
 =?utf-8?B?NzRoT1ArOHNXN2MyU1hQVnE1NTNXVGQzcTcrTEFOSjhyYWdNTnlRVmZsUVA4?=
 =?utf-8?B?dVZIa1JaQVU4bzNTM2xDVW5jdWk5NVFQVUJ2bHNrZ29kQnRIdSs1QW9rbU1E?=
 =?utf-8?B?cDVpQUplSUR1YXFJVDRVK2xEcVlsMEN6WXdENC9tL1YvV29QM3JVVnhyRnds?=
 =?utf-8?B?TFB0SXByRVh1WUFHYnJZYzVOdlRzVWlTNlNUVWdZZXNkL05kQTh6QXRVZ0tx?=
 =?utf-8?B?NW5JSzllNzdqN29Cbzd3Rkh5UFJtN0NLUTBmTHRvRHkxbDF5VGFZRis3anh5?=
 =?utf-8?B?RHJockdabkFWUVF5aWZBcTFEUTFuamVwZVBpT3FvZW45eDlvQW0xMGY5T3JR?=
 =?utf-8?B?RStVZ3JiV01DUm1TcDFHM0dPRHl4cDRHTkc3QW9Yby9qSFZnRVc2NHVLL3dw?=
 =?utf-8?B?eGFaUjdLOVhid29GV3JjZ3B5bnkwK3VBOHhhYW01dUVjRFlmSnhyZEVVeE5M?=
 =?utf-8?B?VDh6clhlS0NwU2VtZmFGN1VRdnJURlR6TFlaZGh2akt2YUQ4dnk1Q1JaM0pJ?=
 =?utf-8?B?Y1BDTzZTTFB2VkowNDhLOEV2Szk4aHJaZU1jbUhEaDdDcU1BcGJla2srT1RL?=
 =?utf-8?B?WXJqU2VxME5Wc1YwZHREOFgxR0NHcVRGNytHVFQzd1pxUlVyUGxSV3NIWDM5?=
 =?utf-8?B?VldXSVcrSHppTFZkRHdCL0VaZFl1dUkycDJpbmxYalgxcHFOeDJJMUd4VlpB?=
 =?utf-8?B?T1Z4S3pXWlhweFJJdWxKcFdPdHVYZ1k4RElGM3BjdXY5akZOdkdYSGFHMjVU?=
 =?utf-8?B?elNZd2ZVWTVOYnlVbjZnak1pK09zS0dIT01IeU9BWDQ1MEgzS1NrWW5RZ01a?=
 =?utf-8?B?bWt1VnNwVkVoRk84UXM5eFdHekFNbXNRQy94TXMvZG1yQ1dSMVB6VmpnWDls?=
 =?utf-8?B?WXhhOGtsZlBIN3MvTXQrN1VUdlVVZXZMMjdnckZnMWlTM2ZuUWpRbDdxRjJV?=
 =?utf-8?B?eEFlS1grN1k2LzB4Vno4Z1M5a3dheFdHMU5kWmVpK1lzbEtxS0ZicVFVTlJY?=
 =?utf-8?B?ZURLZXJtSFlJcnFVdEIzbThVeEZ0eEVOaDY1VTJTaEl0NkRqMk9jQk5ObFI2?=
 =?utf-8?B?dDk5bEFYaXRBcXord3ExZCtsT01BQlk4WDFsT3A1UlphMG5BSHJXTGpLR0xx?=
 =?utf-8?B?SjRxQis2Ry9Kdjk3K20wRlhTZUpWS1dweFhVSjBvRk9aeE9YWUZXQjJId1Ez?=
 =?utf-8?B?a2p1ckNBaXBSNGVudVlDZGZmSHdiUzZER3pkTU5VRUhJY3dleDFQTGdXSUxZ?=
 =?utf-8?B?RFZNUzJiZUdWeWRKM2FVaTF1cmwzeU5SUjNjSFFXamI1TXNYQkZhSDhFemdT?=
 =?utf-8?Q?EPrnklCem/vF2dZpryueOyIaO?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cede16-9e55-47b3-b726-08db6bdcf8bd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR05MB8703.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 07:08:21.4934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra2bmaZe8nLQHbt8J+owOaU/jfd1BSXwXTUl0LiHKihHo68BYVnaHDjVLNTLXoWoQD/ZlO/YBGXnC7O3tj7kuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> Hello,
>
> kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:
>
> commit: a3bb763435d444023d3bca5479da632c57724619 ("[PATCH v3 09/10] eventfs: moving tracing/events to eventfs")
> url: https://github.com/intel-lab-lkp/linux/commits/Ajay-Kaher/tracing-Require-all-trace-events-to-have-a-TRACE_SYSTEM/20230601-230657
> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> patch link: 1685610013-33478-10-git-send-email-akaher@vmware.com/">https://lore.kernel.org/all/1685610013-33478-10-git-send-email-akaher@vmware.com/
> patch subject: [PATCH v3 09/10] eventfs: moving tracing/events to eventfs
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-60acb023-1_20230329
> with following parameters:
>
> group: ftrace
>
> test-description: The kernel contains a set of "self tests" under the tools/testing/selftests/ directory. These are intended to be small unit tests to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: 202306102230.b5aa258d-oliver.sang@intel.com">https://lore.kernel.org/oe-lkp/202306102230.b5aa258d-oliver.sang@intel.com
>
>
> kern  :warn  : [  173.884312] WARNING: possible circular locking dependency detected
> kern  :warn  : [  173.884947] 6.4.0-rc1-00014-ga3bb763435d4 #1 Not tainted
> kern  :warn  : [  173.885501] ------------------------------------------------------
> kern  :warn  : [  173.886125] ftracetest/2186 is trying to acquire lock:
> kern :warn : [  173.886665] ffff88810045d368 (&sb->s_type->i_mutex_key#5){++++}-{3:3}, at: dcache_dir_open_wrapper (fs/tracefs/event_inode.c:373)
> kern  :warn  : [  173.887638]
> but task is already holding lock:
> kern :warn : [  173.888299] ffffffff84e6d640 (eventfs_rwsem/1){.+.+}-{3:3}, at: dcache_dir_open_wrapper (fs/tracefs/event_inode.c:364)
> kern  :warn  : [  173.889183]
> which lock already depends on the new lock.
>
> kern  :warn  : [  173.890101]
> the existing dependency chain (in reverse order) is:
> kern  :warn  : [  173.890898]
> -> #1 (eventfs_rwsem/1){.+.+}-{3:3}:
> kern :warn : [  173.891600] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5693 kernel/locking/lockdep.c:5656)
> kern :warn : [  173.892066] down_read_nested (kernel/locking/rwsem.c:1263 kernel/locking/rwsem.c:1646)
> kern :warn : [  173.892553] eventfs_root_lookup (fs/tracefs/event_inode.c:283)
> kern :warn : [  173.893058] __lookup_slow (include/linux/dcache.h:359 include/linux/dcache.h:364 fs/namei.c:1691)
> kern :warn : [  173.893529] walk_component (include/linux/fs.h:790 fs/namei.c:1708 fs/namei.c:1998)
> kern :warn : [  173.894006] path_lookupat (fs/namei.c:2455 fs/namei.c:2479)
> kern :warn : [  173.894476] filename_lookup (fs/namei.c:2508)
> kern :warn : [  173.894974] vfs_statx (fs/stat.c:239)
> kern :warn : [  173.895410] vfs_fstatat (fs/stat.c:277)
> kern :warn : [  173.895851] __do_sys_newfstatat (fs/stat.c:447)
> kern :warn : [  173.896350] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> kern :warn : [  173.896815] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> kern  :warn  : [  173.897392]
> -> #0 (&sb->s_type->i_mutex_key#5){++++}-{3:3}:
> kern :warn : [  173.898158] check_prev_add (kernel/locking/lockdep.c:3109)
> kern :warn : [  173.898643] __lock_acquire (kernel/locking/lockdep.c:3228 kernel/locking/lockdep.c:3842 kernel/locking/lockdep.c:5074)
> kern :warn : [  173.899133] lock_acquire (kernel/locking/lockdep.c:467 kernel/locking/lockdep.c:5693 kernel/locking/lockdep.c:5656)
> kern :warn : [  173.899610] down_write (arch/x86/include/asm/preempt.h:80 kernel/locking/rwsem.c:1304 kernel/locking/rwsem.c:1315 kernel/locking/rwsem.c:1574)
> kern :warn : [  173.900054] dcache_dir_open_wrapper (fs/tracefs/event_inode.c:373)
> kern :warn : [  173.900603] do_dentry_open (fs/open.c:920)
> kern :warn : [  173.901081] do_open (fs/namei.c:3636)
> kern :warn : [  173.901508] path_openat (fs/namei.c:3792)
> kern :warn : [  173.901963] do_filp_open (fs/namei.c:3818)
> kern :warn : [  173.902425] do_sys_openat2 (fs/open.c:1356)
> kern :warn : [  173.902902] __x64_sys_openat (fs/open.c:1383)
> kern :warn : [  173.903408] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> kern :warn : [  173.903864] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> kern  :warn  : [  173.904451]
> other info that might help us debug this:
>
> kern  :warn  : [  173.905372]  Possible unsafe locking scenario:
>
> kern  :warn  : [  173.906049]        CPU0                    CPU1
> kern  :warn  : [  173.906538]        ----                    ----
> kern  :warn  : [  173.907027]   rlock(eventfs_rwsem/1);
> kern  :warn  : [  173.907464]                                lock(&sb->s_type->i_mutex_key#5);
> kern  :warn  : [  173.908171]                                lock(eventfs_rwsem/1);
> kern  :warn  : [  173.908800]   lock(&sb->s_type->i_mutex_key#5);
> kern  :warn  : [  173.909291]
> *** DEADLOCK ***

Steve, this seems not to be a problem here as dcache_dir_open_wrapper()
and eventfs_root_lookup() both lock eventfs_rwsem as read lock, however
it’s known problem in Lockdep for rwlock:
https://lpc.events/event/2/contributions/74/
And available patchset on Lockdep not upstreamed:
https://lore.kernel.org/all/20190829083132.22394-1-duyuyang@gmail.com/

-Ajay

