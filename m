Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1B702B9F
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbjEOLjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbjEOLhU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 07:37:20 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012005.outbound.protection.outlook.com [52.101.63.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178621BE4;
        Mon, 15 May 2023 04:35:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cydSSSl/eVM734c9PmcOP6IjShpLKekmQ7ZfH5tphuvAyP6sFYeh7dHNEGlyCaeniuhKA8DOXQxIT0TlhVugcecXIUuwd7nIqoo0CY50exRUeqFVkhXGLipa/vhUxcgTXRINHKPa5/Hq5cDa+JeEc7Pux+2wLt00bRMwpL5uMjNpySZTypf7rcImYmHP6QaWeSZ5Ro14LWKohNHPV3QsOrJ6JT29sdcYePtuyIUAivvfPjymIcnM7WX1nxh3VP0bnO/B/B6DmZqE29rASloWdy7UZsJ17RS/sD54K8rDbgudDhjgkAYxXEm6CLBZsaD8w+YNxHj869CRQCVF/75c8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi7GTupPW2stxNxhyYR0GR887uYJ+TAImZC9lluFQUk=;
 b=YkapL3+CKAeyAhb6s/9P9iMHF95QGCS4DRpREujEUYnz1IErejNd9j0v7r4j1lEgqa2EWn/TIieSEkJtcEK8Ld0ym/Ou/Vt88TMWNT8wbOQLnOzXevunAydSoQVvTMSem49rcSCAiCb0XkjzMi7YDR262OWohcx7Hsi7PqU0FmWXmZGFq4pcuFqxBnuSHwQDNM0i9dSB5RJndtsz237fa24w0M2C0JzUg9wUdjR/wG7soNQZsV2lj6Ox91RV31mkKmlkTst3Gq92axDbx/0xarIJornpdpA2OvNO9rZ0f3bF/0kAOrKXOwSyTk/IB8kRrnaG7JMBHRnFw0mxOFtZCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi7GTupPW2stxNxhyYR0GR887uYJ+TAImZC9lluFQUk=;
 b=xMNuUY4kJHVoJjWCdAUEXVlQoMQW2WQO5vOwYvUpLunYA5KEcVnvyj7gcZAQAF6kYXB3U6DvkPZJddfvsxDRC7Q7HJVNnLKHbHx6EAHV+BkmbQBcnVv7QpfXoG6w8zNvbfjX2kVkoW2QzgywMs1dQMTA4gNPySCzToeN/aHJsy4=
Received: from MW4PR05MB8699.namprd05.prod.outlook.com (2603:10b6:303:12a::12)
 by CY4PR05MB3639.namprd05.prod.outlook.com (2603:10b6:910:59::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.28; Mon, 15 May
 2023 11:35:20 +0000
Received: from MW4PR05MB8699.namprd05.prod.outlook.com
 ([fe80::e109:9b20:9985:a286]) by MW4PR05MB8699.namprd05.prod.outlook.com
 ([fe80::e109:9b20:9985:a286%5]) with mapi id 15.20.6387.028; Mon, 15 May 2023
 11:35:20 +0000
From:   Ajay Kaher <akaher@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     kernel test robot <lkp@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "chinglinyu@google.com" <chinglinyu@google.com>,
        Nadav Amit <namit@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        "er.ajay.kaher@gmail.com" <er.ajay.kaher@gmail.com>
Subject: Re: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Thread-Topic: [PATCH v2 8/9] eventfs: moving tracing/events to eventfs
Thread-Index: AQHZfOilHbAIv3gBO0Sfrm8lUvOVTK9HSCgAgAr9/YD//+uAgIABNMGAgAPqiQCAA/fagA==
Date:   Mon, 15 May 2023 11:35:20 +0000
Message-ID: <BD75F325-8347-4334-A62B-C38864933504@vmware.com>
References: <1683026600-13485-9-git-send-email-akaher@vmware.com>
 <202305030116.Gu6yyvKj-lkp@intel.com>
 <1CAC8265-A4F3-4AF6-80E4-8F264ED670A9@vmware.com>
 <20230509124559.0d5557ad@rorschach.local.home>
 <400E4466-629C-4306-86B1-E8BA0CB5EF66@vmware.com>
 <20230512185916.22bda1a5@rorschach.local.home>
In-Reply-To: <20230512185916.22bda1a5@rorschach.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR05MB8699:EE_|CY4PR05MB3639:EE_
x-ms-office365-filtering-correlation-id: 023ee593-ddd6-4a13-5e77-08db553876f3
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EVNwC6uV18XF8cC0Ob+e5IC9Z10qMVO3HFmsUQJJGmqiwV2LQRChyXWksbbqOyQmJhTAvmdjgQLY2cFs5NupF+3pHaozOSOJEAKdGixNYaCA0cJrDDyUbp9GCfqKKCHvjhH9DxWYgcwOHH85zsPzFNRRA9T3zq2kVJcUY+F7iy6w39L7Bm8MhJDZ8CSjSXt+PTFJGeEjQPeKFR9t2WHHIBfu19ACUa8+oNINlaFxoYd8fu1ovex+3lfHsoWKMUvVMQULOldAHFm5FfADz41n/uuj5Er232apVYSrkHg7YZedw1hLvCXYQHdX7MBsmopmgIkRnEKaoMjBHYfKKDsdxZkWBucNtaK5P8qnwQkqhGeUbgi4j5gnS0YaHTXqLakzIBxoNtwtSZPSMvG8RppdQROreMXYu7H/S7J/etIJ6n+97lFggsk8otRLbMRDaJi9TyGQmszWnMxjeSDPSkvWrXtMRGTC2X9dbv82GpE9hzX21Kh36Ld4OhOzXvKbR9f7yfallpYFnZ8822/HNnex6UPgl20PEejOFLwh/+PaScV3Kenu3H3f3ht34gS+b1EtmMS4BvUrtflH2lVAC45jmIhXUuQbQm6hQlBjmj8lFm488N6BIBOl1S2gnFvrPHFiHUHYYGDJW3u1YTONtON6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR05MB8699.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199021)(4326008)(316002)(6916009)(41300700001)(36756003)(38070700005)(2906002)(38100700002)(122000001)(53546011)(6506007)(6486002)(26005)(6512007)(478600001)(66446008)(66946007)(66476007)(64756008)(66556008)(76116006)(2616005)(91956017)(5660300002)(4744005)(33656002)(8936002)(8676002)(54906003)(86362001)(186003)(71200400001)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OPCQw4sovzO790OuHAhkYWhSmWWenw0HtT5/fwCQ1PcObq8z9pxHJaUTbcST?=
 =?us-ascii?Q?QRQ3kamtciq+eIKfJBBOT4/6BI1JJ72RfBeevAtHv08LvDdfBHUJ/aEWlDm1?=
 =?us-ascii?Q?ABYdjAum/RoKQWYTl+J0WMNfgTqeyx5nBWdyn2NA2nMmZPDEVjdoVLAZTVsG?=
 =?us-ascii?Q?4WuWvZ2wuKzsZOg8OTp/N9wcvzISqowYFzjTrRf4ltK8RtJnOHR42fe+jW+7?=
 =?us-ascii?Q?fJbM9utMEycFk56fFLBcG+TiCWdQK7iDOkTO0j98kx3S6c6Wd53J2yREMXO7?=
 =?us-ascii?Q?z+v/mH/fQIfutYt7dCpNX6t12T/S3NrIJKuSoyl61FJWHkGAGAuhmLs+O2Rt?=
 =?us-ascii?Q?HMSrjgHW0xQ3NBAsq9EtlTumgS7A2xLNem3eT7N9N5R8aMNmEyJYMTUaRecU?=
 =?us-ascii?Q?2K22CBUCvUJlq2TOXR8ASQ20TIFEDItjBzuDybqTewIiU5Fs7X4Mc0PmLkHl?=
 =?us-ascii?Q?LDhCvfuxFIgvZLEGDVDG436494YNmFHzHvzOC6NVXzC2wZgMEPEbnDfybYX9?=
 =?us-ascii?Q?a1EOXbf1TYygTmmYcHEKBX1HlQRq0rM5rf3+L0kn9Yb7fv5p6X5A6aDg62pK?=
 =?us-ascii?Q?MAV/JYaVwkWv6+ki2FZwdSNJsOtvmJNQZLVjy4MZBVmcvXS7rFG11Cmb1YbP?=
 =?us-ascii?Q?hyxbPMfo/niPGyKAiQWvOZbg9VyTfemflR8xprEaJhEBLqOb76tpinRY3/zB?=
 =?us-ascii?Q?dKMeTaboj+q6Q0HlIa5l0BOzqheI+zjGaynGuRbYuSyOfPHx+q8y6v4iXfG5?=
 =?us-ascii?Q?R0Kajimf+V9QYidyxoQXil+PuHr0INiSlEMrTxxugkUeCE4ZH/0DOiGjqspz?=
 =?us-ascii?Q?KJkrmDfTmGrIwUjXrIH9cpdtToCGsUgSX9nk3UfY1m7d0P759Lvljlkzp80W?=
 =?us-ascii?Q?fmDGfnrS5AfsUSUenvc3J4kfzkDHkLDdT9QemQns0QhsDPHmuVkm/RdqYAYP?=
 =?us-ascii?Q?DmOQy3/KPp+AQJIP6pf3OtYOV/NADVUyyLjphPXlfSWfwWQqPr+6ylDMHdiL?=
 =?us-ascii?Q?41vvJmtqn9Lci7bu6K9F2q+8vO63AT0cSqvkaiTzMB56MtgViLzypecDeRFn?=
 =?us-ascii?Q?BVbqsWtIqKii9lBdCP9+9ICaT4/8C+BnyNnh7jSzlcpjIyXc2NfX/ZBAEC8B?=
 =?us-ascii?Q?Ee9QKq7s8k1V9EHWs36xoCCc986fLckSySpkdMM8689h5jmd4/cGMV08Hz/I?=
 =?us-ascii?Q?T6JiADCqsLRISXUuVptatqiIxQLaIwen6mo+m7d+aGVNntQhlgSHRBCyPD9+?=
 =?us-ascii?Q?ldNvUJZTgO+rz6J8iVJUETOmdg4RWOo3gRSt5sRPPf6Px7BCgEkH9BVZ5Ygk?=
 =?us-ascii?Q?PWcFjZCqsevOjEKTNZIiGvDIPYnFNcpeIV+vAHJyS2msh+SH42rTSNRMIRWJ?=
 =?us-ascii?Q?td5hZPgDMvJxcKVKh87sjbwAkoeNKGf/LWeG330SccenbEXfIYMplw52TgxF?=
 =?us-ascii?Q?365SANHMoj/IqEDyBWdKjz1jYQmL9ni1j00Wfeso3ddPcd7UKLq7pgyuQDk5?=
 =?us-ascii?Q?lKNQrxD4ZEpBpQxL/rJiYolrGl9vJBpF0viG9Nbg8i7u2CfRt+ncz3sFsdzl?=
 =?us-ascii?Q?hExouSPvSB6HI9A/IVl2Q4gnnE6DZlYYG50J8eQz?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <098E2006ADA42E48898AB43F88B025AE@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR05MB8699.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023ee593-ddd6-4a13-5e77-08db553876f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 11:35:20.4907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5AkLwpPuRfZ9f5pQ2vq5BGNQylYNOeW+RhPnOFG3eHWCTAkmfukgEWAgP2ZO17SM24aT/X9zBikcJiWOiDZhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR05MB3639
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



> On 13-May-2023, at 4:29 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> !! External Email
>=20
> On Wed, 10 May 2023 11:11:15 +0000
> Ajay Kaher <akaher@vmware.com> wrote:
>=20
>> Sounds good. Thanks Steve :)
>> Once you will merge below patch, I will rebase this patch in v3.
>=20
> Feel free to just add it at the start of your queue. You just need to
> keep the "From" line and it will be added as my patch.

Ok, I will include in v3.

-Ajay
