Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DF68E624
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 03:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjBHCkm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Feb 2023 21:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHCkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Feb 2023 21:40:39 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 18:40:37 PST
Received: from esa15.fujitsucc.c3s2.iphmx.com (esa15.fujitsucc.c3s2.iphmx.com [68.232.156.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180239B9A;
        Tue,  7 Feb 2023 18:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1675824038; x=1707360038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=et1y1Pbt2hg3nTSRsg1DOGsD9/l6zIdQR0iNOU+mzzA=;
  b=sj1gDJFJHUTsY+w0c4EsNqMv5JS3oNhpebOwGefigoU00roLi2VfiQpD
   j9tr4guMUNW0mwpinx7F2jQ85WG2M04frc2Xfc2XkykL0HLQ6jRfhNURM
   ZdARAPqOI0i1DTuK1Gje72LHQkLqhDU8u/caY+g9/8ec3gW6cihwTK1uZ
   5sGc1ozKFzYzV8c7bDxJ5xjUF8QesUp3wUCu3yidAVn2B0GJ04ixS9nQF
   +thIEDFHiEGo6jAPHsQqCUxOgadibSdxbEC+WcqPEQ7XtXU7f5SjJqxre
   V7W+XtinH229JVc4fqWgdX9sY7OQnaAUQKvC4E6IYv/fO8IQRFUg+g21f
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="76454672"
X-IronPort-AV: E=Sophos;i="5.97,279,1669042800"; 
   d="scan'208";a="76454672"
Received: from mail-psaapc01lp2041.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) ([104.47.26.41])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:39:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtqwIMc036DB/S4Yms31bIPTpOyWUkzAMxvp7VSq33sau8+Oun60nrCKUA1zey7fm2wmtUUOB2udJWtdPija0VrwzaFXhUGfYBGyVIsy4nq3Bt8PlkePUQVDqSuXdorP9IkkzaO9ntiuu4XJJ2rfIB7wObEcfjzuz63VcRBKDASSwpPiwGlXvVd1QT91JL+AHH40L13gnATAiZF156TBXI945l1LcTrrCA80ZDDVWLAV9Z+AfPXAgCJXwF9x9aY+ZB8aQHimky6nz2Ds82P7W0EYYWkHsH3hNQxruHsI16L/lfxOb5xfV0sFfjtMlX59NwZCQq1Drlt3kzmtTAwoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et1y1Pbt2hg3nTSRsg1DOGsD9/l6zIdQR0iNOU+mzzA=;
 b=fUQS1EiGHFmDCTlBkcX9SNMEZUF9P5nOP1kkFral/aFcmjZUKNcxkTce971MeSkRLsdiai5AcyTiGhJFOwLmMdnNGejFd1z/CDyVFxFzq3kuvPlzxIxPyRPHRSR6zqggiZXYdF8LVtQNnFoo8c+qP77xWSe0gpq2ReH+c7LXlyp5naLplVHSGT5vgdsJzaGjZrs2vYUu7MDG6MbKY2Bgpnc90XppsqggcKRKgSgiNS/TNnZ91/+ViqpP3CEo5l4tzBCR5Ws/v3jQme4VD8pKVUg64NMBeGp3taqUB2BReGn9Yu5IpP2G4mJM03TytGuvh4Q4RvBcjJ0gDhinmc9caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com (2603:1096:604:e8::8)
 by OS3PR01MB5685.jpnprd01.prod.outlook.com (2603:1096:604:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 02:39:27 +0000
Received: from OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::2c7c:9e83:3a3d:4038]) by OSZPR01MB6328.jpnprd01.prod.outlook.com
 ([fe80::2c7c:9e83:3a3d:4038%5]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 02:39:27 +0000
From:   "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To:     =?utf-8?B?J0lscG8gSsOkcnZpbmVuJw==?= 
        <ilpo.jarvinen@linux.intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Topic: [PATCH v6 4/5] selftests/resctrl: Cleanup properly when an error
 occurs in CAT test
Thread-Index: AQHZNTfwUctSaAnC40SoDIvwW0nv4a7Dj+oAgADSIXA=
Date:   Wed, 8 Feb 2023 02:39:27 +0000
Message-ID: <OSZPR01MB6328AE8F77449F7D6C7DE8958BD89@OSZPR01MB6328.jpnprd01.prod.outlook.com>
References: <20230131054655.396270-1-tan.shaopeng@jp.fujitsu.com>
 <20230131054655.396270-5-tan.shaopeng@jp.fujitsu.com>
 <83e1de31-b448-1a51-ba39-faec794694f@linux.intel.com>
In-Reply-To: <83e1de31-b448-1a51-ba39-faec794694f@linux.intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfRW5hYmxlZD10cnVlOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJh?=
 =?utf-8?B?Yy1hYjRkLTNiMGY0ZmVjZTA1MF9TZXREYXRlPTIwMjMtMDItMDhUMDI6Mzc6?=
 =?utf-8?B?MDlaOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0?=
 =?utf-8?B?ZmVjZTA1MF9NZXRob2Q9U3RhbmRhcmQ7IE1TSVBfTGFiZWxfYTcyOTVjYzEt?=
 =?utf-8?B?ZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX05hbWU9RlVKSVRTVS1SRVNU?=
 =?utf-8?B?UklDVEVE4oCLOyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9TaXRlSWQ9YTE5ZjEyMWQtODFlMS00ODU4LWE5ZDgt?=
 =?utf-8?B?NzM2ZTI2N2ZkNGM3OyBNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1h?=
 =?utf-8?B?YjRkLTNiMGY0ZmVjZTA1MF9BY3Rpb25JZD1mNWNiYzQxMS1jZGVlLTRhMzEt?=
 =?utf-8?B?YmUzYS1lNWNjNThhMDUzMzE7IE1TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00?=
 =?utf-8?B?MmFjLWFiNGQtM2IwZjRmZWNlMDUwX0NvbnRlbnRCaXRzPTA=?=
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: cc277dac4bdc4d7f819189f30012963a
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6328:EE_|OS3PR01MB5685:EE_
x-ms-office365-filtering-correlation-id: 1131b99b-31a0-4b5b-a0d4-08db097db29e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ao2/6Q2adW/PWBfzJULAgE+9bIX1YpTe50UG0xB/stOeCiLzKrUuttR1HCrXThCLTsbIcYto74qi4LjJyPsVyE62fIRqrT2a+Hs0hlRTosCJX0Tt8NPk0gnk+WVpxcLl1B00XQrcRQRHcIHx0FI5WEjVJR+MFOu6bLaapk1x/ryBazaEcrPF4X5HstxoDzhqPxRDIepZ31im5TsvLYRNc6y8svMsPVPxRyHsQh/vOFzDqYbgXUhsjSMnwaxh3d2y5DDP86Ua/r1BhcWivg6cuqG9Ut1pLWoRlJwfmoB5sr/TBwJK5e5n8IgwTy7+WYDu5w/7FijLr5QZL6hpYtw8/z7iPM5r6t1Ii8RFIr43CybF3JFKCdw3qLpZsuje1imUJxMvx+/VfmcjHoBF8q8TIqXx2xs4v67Dm7SwGSk4eGYRHooJR3tvQ9Hg/NWOrZlNrgTQnXd7f5OInUb5gcSPsxudv3B8Xhxt9g+dbBpJ3tcWuhZB5Tl1GseqxsG+3e5zfQ0UVQUj1wlEPI2KWxkKNLArZ0h8GbEPaRlzs8bAWQOXnoP8rK5fBk5xGPEPUi4k+wltIeUoltd4qbBYMOInj/Vgj/lf6KNi9DKnav1gakmIJG0Tf/nS6SM7HtrvkUdQRiqXoWgKZ0zgExokdV+Y0ZIedtm8LJVac/ABgPa2L2ynNWWacJBnkh21AkrzIJmwtExUToEgni44BMXVHwD4e14LjysyXktf7a7A+naAhjk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6328.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(1590799015)(451199018)(8936002)(2906002)(5660300002)(41300700001)(6916009)(8676002)(66446008)(66476007)(66556008)(66946007)(64756008)(4326008)(76116006)(1580799012)(52536014)(316002)(54906003)(83380400001)(55016003)(26005)(186003)(71200400001)(7696005)(85182001)(478600001)(9686003)(6506007)(33656002)(38100700002)(82960400001)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eitnNkl5RDl2TlU2UFRORFkvOGZOUWlmWks1M2NvWnowSUJzRjUvaUFtckw0?=
 =?utf-8?B?MUovYU84YW9mU21JZ0FPQVRTa203eFNrWGczZEtHT0NhTjNUQldRMUZxakdK?=
 =?utf-8?B?VSs1YzBYdklOVVFWMVpwb0pjNVNrUXRrdHYxZlF4Y0twRjBOOUo3OGN2YkJR?=
 =?utf-8?B?UFdGWDNEcXZhSVZaZ3JrOUo4SWMzN3hLUWVhT3Voa3A0cWxFVTR4SC8vSGVD?=
 =?utf-8?B?Yk9SdG9ETEVIdE5mS2QvSnFoZHhUSFdEMEZ1VUlCaStUYlA4a2xBS2tPVDlY?=
 =?utf-8?B?aXVlOEUraStNZU93KzNWR25yY04xeGtBMFBRRHN3c2JVc0RaUlErWnpwbk45?=
 =?utf-8?B?NEVOOGpYMzZYb1lJcGhRTUVzQnltVDNKL3pCM0xYdWV5YXhjbGJkRFhib2Jr?=
 =?utf-8?B?U2E1UTNSZ051K2RWZ0NpeHY4QXlXL042ZzRvV01qdDJoVTA0czkzazUzKy9m?=
 =?utf-8?B?cERyMnZjTWVtVWg4RDgrenpGVUkxYlZwSWFoV3I3YnE2a2ZDMzNjd081RjZv?=
 =?utf-8?B?WElMRGx0YmpKYm5TUW5mY05jUjBPTE14TUgwYk1JVS9ra1NSYS9SVXpGVnZp?=
 =?utf-8?B?cnRkZ1djUFk2OGtsdnk5ZEVTcTU2amJFdlpQTW9FNHM1bVdWdlBLak0rZ1JC?=
 =?utf-8?B?UGtyUnJWVWpDRHI2U0dIOTRoRFFwSVpGWFg0bkhkWFBnS28rMEl6QTUrbWJx?=
 =?utf-8?B?VU1JQ0hMMk1qRG1DOGVxeU1SV2g4c1M1SDl2T3VXVVlXcmlMNGxSSlhyM3dq?=
 =?utf-8?B?cUhETlhWS3lRYW85d2p2Rm1KUWdGZXEyaGhBaHNaSXlqR25SMkYwdmlVK2pV?=
 =?utf-8?B?aVB0aE8xNnQ4bHAwNkx1QWRPZVpyUHVrMVlJUDhMekdwUkswcTZ1WEs2WnBa?=
 =?utf-8?B?SGVhYWs3cHd1Q1JBR2g1RXhBS0NwQU5yV1pGVGx3WTY2T0d6bXN4REdjbUJD?=
 =?utf-8?B?RGtzVktEUGl0dEtCYlE1OUsrZ3BUeUlndGtpSVVvVG9FTTVMcTU5ODhxd0V0?=
 =?utf-8?B?UU81THZ1eVIzQ1dsb0NEV0VjeXc3S1k2emU1dzh2cDV5QVpxbWFxMG9LU2Vo?=
 =?utf-8?B?L1hpRVphWDZ3SGVQY3dPM3A3UGFKb3h2UHNiTE52N1liVHNMNDBNUzBvcWY1?=
 =?utf-8?B?cEtmZko0eUR4UUExajZ1UUdPODZ0c24vb1J1dzlSTU9VZGpSb3JJQ2dodUV2?=
 =?utf-8?B?RHlUU0ZvaEJGQUJwcXZ4NEJkaFVhSWFSbTdzYnZxRWlKbVlYRjlnc2hHTXRa?=
 =?utf-8?B?dnQwK0FmWFhxMk1zNmpXRHZUZk9tTE12SmF6U05XOU1WckxZcnlLN1RhOS9M?=
 =?utf-8?B?RHdXT290cmNGL1loY3ZPU09Gc1oyYVpINnlBWFVQY2ltcnBOUUNHQ2x5aWlV?=
 =?utf-8?B?OTh5VEtITW5qY050bTAxM2dzZms3SHQyN1J0azVFdUVLNHR0UUx3ZmNMM09n?=
 =?utf-8?B?bUkzQms4R2VORDYzeVIzbGFNT2YwTGlWbUpJZHRJdExkNmxaVk9BSXR4aUJI?=
 =?utf-8?B?MFhBbGVYd041SmtILzVQR2ZoU1hWTjVRWllZa0JwT3dtWnQwMUlBdHl5SFhQ?=
 =?utf-8?B?MzJXSW85aUN3bE5halNBRG93MkYzdldPN2kreGdTc2xERVFuQjFkMC9wQWxj?=
 =?utf-8?B?ZE4rSnEzNUJraWgyNnBmbEVqN3BoeWsyQjZmOWJZaGpMT1BFbi83aFA4K25o?=
 =?utf-8?B?UGpsMWNzaGpIRm1jdlFLaU1nVVZIN2p6VmZ1TDRiUk5UNXBSeXpYT3VSS0ZD?=
 =?utf-8?B?TDh6QTErdnE1azMzZXZvc0o3TmNjZmtrQ0h0MjRRTkRWQldKZW5yWVFDakN4?=
 =?utf-8?B?anF1VG1TVFNOakE2eDV2Tkt1eVVxU3E1dUppMm9ZRlFmZVRlSndieFBSYWtK?=
 =?utf-8?B?K2RWNzBGMWZYRkhrYTRXdzJGbVhEOTZvWEY3UmNWTzhTU0cyUXNHZEtsTnhD?=
 =?utf-8?B?M2lQbG9KbzZnek1rMVZZakNoTEs4eUxQcndNcEJYQUJxSDBaUStCU3EweFpW?=
 =?utf-8?B?aHh1aDg5d2ZmZTJseWh1c2c0cHZ3SzRzZGJrUmFoL3AwbDlFRHgxNitmZkl0?=
 =?utf-8?B?d0xrWC9jZ2hPaGJNRFRES2xPd0FlWVhHdzFPM1lhUzRqa3h3cXJ1VFZXOTRz?=
 =?utf-8?B?Y3A5Ni9RNXNNYkpmNGxKcm80M0RqUXNtdHZVdVN4QkdlTm9YMU94N1BXZzdu?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LZBvddNUOJ+qommrKUN6or/oeCU9ww01EYVnnZYg+25ggTjjdQ0DiqIidivMQ0MjLtBu8glzNqoTNeyQ4XWPoAq/slNsxrqOw152kpsYV5B47iXTUkVP6nSNiwEeJewq+bjJh/DQ0B/vPHeelLTDC/3XysOBj+fLbhNlFW9z1GbKkv+lVzPE+ZnHrUT1I42FVMYn28LSs9ocpMZxS3KylpctNtgwwds47hkbND5j31xeWsrh5G+9mWeGtQz7YOti6R0YsFaWiIbvy82hL0SYNwAug6X3Ncko5x6prbwOICqvsINYVYrfAK2G0WEF/PfGNWQWamz79lb+K8V/N8yhJBOeoUL1g/+iGLcCWbglz/CdTSPqr1HWLYSgqt/uJhrF9DxoCxb9kxsuowARi1EcfTK3HiGz3VFV6EEevtODjZ+xDdLqfsMVUyzuAhN9AwpZ5wevRESlAwNyA6Ytx8gyEtVzAJh1UmecdMMwxmhhuuOyvRBjaGgJBGLyEtb+pD58T/zQC1BT1pGCLKX24VT1VLmxmnn9ODjxWc1T7S5Vt1Mev8E/SnR1pyeTeZLKNj0sminYQiIs0fB1u96+P4CjEwpXCx0+TDudKOmuTHSPjn5IeQfvWLCqndHiTbpTkghvpb+e0SQmwEbjjWBxz1VfAlcnRC1gQ610g0rtR6rmkskulGcW7D28qYjsPUMNrAXUa0bSbPTInQ91ZZfY+Od41DLYEoL3GDZUnA4xwx4wAYSvcmnBN2NSJW+evNW/0QP4NrgdbCEcFh94X3jp99Qme571ctHeAoQ8wwuLxLDL0Us9sVKC6OnzLphk+oOGljbyl36nrPvltNSxOqoRvd61IA/Ub61NttQc5lCaxBJJGaTTStPWos+KXD/KajFD3qCz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6328.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1131b99b-31a0-4b5b-a0d4-08db097db29e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 02:39:27.4734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UbRXTBNRAvsZl2dek+FjPT40zz2rxX/Xafrzi7einrQiMtS2p2gzR73Uc9w2v2Bpr1PZnDfbYB9LkHFxQSyunfkJJ5OB4xJTFvKtfgNmdxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5685
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SGkgSWxwbywNCg0KPiBPbiBUdWUsIDMxIEphbiAyMDIzLCBTaGFvcGVuZyBUYW4gd3JvdGU6DQo+
IA0KPiA+IEFmdGVyIGNyZWF0aW5nIGEgY2hpbGQgcHJvY2VzcyB3aXRoIGZvcmsoKSBpbiBDQVQg
dGVzdCwgaWYgYW4gZXJyb3INCj4gPiBvY2N1cnMgb3IgYSBzaWduYWwgc3VjaCBhcyBTSUdJTlQg
aXMgcmVjZWl2ZWQsIHRoZSBwYXJlbnQgcHJvY2VzcyB3aWxsDQo+ID4gYmUgdGVybWluYXRlZCBp
bW1lZGlhdGVseSwgYW5kIHRoZXJlZm9yIHRoZSBjaGlsZCBwcm9jZXNzIHdpbGwgbm90IGJlDQo+
ID4ga2lsbGVkIGFuZCBhbHNvIHJlc2N0cmxmcyBpcyBub3QgdW5tb3VudGVkLg0KPiA+DQo+ID4g
VGhlcmUgaXMgYSBzaWduYWwgaGFuZGxlciByZWdpc3RlcmVkIGluIENNVC9NQk0vTUJBIHRlc3Rz
LCB3aGljaCBraWxscw0KPiA+IGNoaWxkIHByb2Nlc3MsIHVubW91bnQgcmVzY3RybGZzLCBjbGVh
bnVwcyByZXN1bHQgZmlsZXMsIGV0Yy4sIGlmIGENCj4gPiBzaWduYWwgc3VjaCBhcyBTSUdJTlQg
aXMgcmVjZWl2ZWQuDQo+ID4NCj4gPiBDb21tb25pemUgdGhlIHNpZ25hbCBoYW5kbGVyIHJlZ2lz
dGVyZWQgZm9yIENNVC9NQk0vTUJBIHRlc3RzIGFuZA0KPiA+IHJldXNlIGl0IGluIENBVCB0b28u
DQo+ID4NCj4gPiBUbyByZXVzZSB0aGUgc2lnbmFsIGhhbmRsZXIsIG1ha2UgdGhlIGNoaWxkIHBy
b2Nlc3MgaW4gQ0FUIHdhaXQgdG8gYmUNCj4gPiBraWxsZWQgYnkgcGFyZW50IHByb2Nlc3MgaW4g
YW55IGNhc2UgKGFuIGVycm9yIG9jY3VycmVkIG9yIGEgc2lnbmFsDQo+ID4gd2FzIHJlY2VpdmVk
KSwgYW5kIHdoZW4ga2lsbGluZyBjaGlsZCBwcm9jZXNzIHVzZSBnbG9iYWwgYm1fcGlkDQo+ID4g
aW5zdGVhZCBvZiBsb2NhbCBibV9waWQuDQo+ID4NCj4gPiBBbHNvLCBzaW5jZSB0aGUgTUJBL01C
QS9DTVQvQ0FUIGFyZSBydW4gaW4gb3JkZXIsIHVucmVnaXN0ZXIgdGhlDQo+ID4gc2lnbmFsIGhh
bmRsZXIgYXQgdGhlIGVuZCBvZiBlYWNoIHRlc3Qgc28gdGhhdCB0aGUgc2lnbmFsIGhhbmRsZXIN
Cj4gPiBjYW5ub3QgYmUgaW5oZXJpdGVkIGJ5IG90aGVyIHRlc3RzLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogU2hhb3BlbmcgVGFuIDx0YW4uc2hhb3BlbmdAanAuZnVqaXRzdS5jb20+DQo+ID4g
LS0tDQo+IA0KPiA+ICAJaWYgKGJtX3BpZCA9PSAwKSB7DQo+ID4gIAkJLyogVGVsbCBwYXJlbnQg
dGhhdCBjaGlsZCBpcyByZWFkeSAqLw0KPiA+ICAJCWNsb3NlKHBpcGVmZFswXSk7DQo+ID4gIAkJ
cGlwZV9tZXNzYWdlID0gMTsNCj4gPiAgCQlpZiAod3JpdGUocGlwZWZkWzFdLCAmcGlwZV9tZXNz
YWdlLCBzaXplb2YocGlwZV9tZXNzYWdlKSkgPA0KPiA+IC0JCSAgICBzaXplb2YocGlwZV9tZXNz
YWdlKSkgew0KPiA+IC0JCQljbG9zZShwaXBlZmRbMV0pOw0KPiA+ICsJCSAgICBzaXplb2YocGlw
ZV9tZXNzYWdlKSkNCj4gPiArCQkJLyoNCj4gPiArCQkJICogSnVzdCBwcmludCB0aGUgZXJyb3Ig
bWVzc2FnZS4NCj4gPiArCQkJICogTGV0IHdoaWxlKDEpIHJ1biBhbmQgd2FpdCBmb3IgaXRzZWxm
IHRvIGJlIGtpbGxlZC4NCj4gPiArCQkJICovDQo+ID4gIAkJCXBlcnJvcigiIyBmYWlsZWQgc2ln
bmFsaW5nIHBhcmVudCBwcm9jZXNzIik7DQo+IA0KPiBJZiB0aGUgd3JpdGUgZXJyb3IgaXMgaWdu
b3JlZCBoZXJlLCB3b24ndCBpdCBqdXN0IGxlYWQgdG8gcGFyZW50IGhhbmdpbmcgZm9yZXZlcg0K
PiB3YWl0aW5nIGZvciB0aGUgY2hpbGQgdG8gc2VuZCB0aGUgbWVzc2FnZSB0aHJvdWdoIHRoZSBw
aXBlIHdoaWNoIHdpbGwgbmV2ZXINCj4gY29tZT8NCg0KSWYgdGhlIHdyaXRlIGVycm9yIGlzIGln
bm9yZWQgaGVyZSwgdGhlIHBpcGUgd2lsbCBiZSBjbG9zZWQgYnkgImNsb3NlKHBpcGVmZFsxXSk7
IiBhbmQgY2hpbGQgcHJvY2VzcyB3aWxsIHdhaXQgdG8gYmUga2lsbGVkIGJ5ICJ3aGlsZSgxKSIu
DQotLS0NCi0JCQlyZXR1cm4gZXJybm87DQotCQl9DQoNCiAJCWNsb3NlKHBpcGVmZFsxXSk7DQog
CQl3aGlsZSAoMSkNCi0tLQ0KDQpJZiBhbGwgZmlsZSBkZXNjcmlwdG9ycyByZWZlcnJpbmcgdG8g
dGhlIHdyaXRlIGVuZCBvZiBhIHBpcGUgaGF2ZSBiZWVuIGNsb3NlZCwgDQp0aGVuIGFuIGF0dGVt
cHQgdG8gcmVhZCgyKSBmcm9tIHRoZSBwaXBlIHdpbGwgc2VlIGVuZC1vZi1maWxlIChyZWFkKDIp
IHdpbGwgcmV0dXJuIDApLg0KVGhlbiwgInBlcnJvcigiIyBmYWlsZWQgcmVhZGluZyBmcm9tIGNo
aWxkIHByb2Nlc3MiKTsiIG9jY3Vycy4NCi0tLQ0KICAgICAgICB9IGVsc2Ugew0KICAgICAgICAg
ICAgICAgIC8qIFBhcmVudCB3YWl0cyBmb3IgY2hpbGQgdG8gYmUgcmVhZHkuICovDQogICAgICAg
ICAgICAgICAgY2xvc2UocGlwZWZkWzFdKTsNCiAgICAgICAgICAgICAgICBwaXBlX21lc3NhZ2Ug
PSAwOw0KICAgICAgICAgICAgICAgIHdoaWxlIChwaXBlX21lc3NhZ2UgIT0gMSkgew0KICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKHJlYWQocGlwZWZkWzBdLCAmcGlwZV9tZXNzYWdlLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHBpcGVfbWVzc2FnZSkpIDwgc2l6
ZW9mKHBpcGVfbWVzc2FnZSkpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGVy
cm9yKCIjIGZhaWxlZCByZWFkaW5nIGZyb20gY2hpbGQgcHJvY2VzcyIpOw0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgICAgICAgICAgIH0NCiAg
ICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgY2xvc2UocGlwZWZkWzBdKTsNCiAgICAg
ICAgICAgICAgICBraWxsKGJtX3BpZCwgU0lHS0lMTCk7DQogICAgICAgICAgICAgICAgc2lnbmFs
X2hhbmRsZXJfdW5yZWdpc3RlcigpOw0KICAgICAgICB9DQotLS0NCg0KQmVzdCByZWdhcmRzLA0K
U2hhb3BlbmcgVEFODQo=
