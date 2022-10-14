Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9915FF1AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Oct 2022 17:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiJNPrU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Oct 2022 11:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiJNPrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Oct 2022 11:47:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AB3476D6
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 08:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guYemKwPPosmfn/Lnw5vfbWmmFwSpGY8WWZ6248giVrSDyJjgl2CJztho/v7pSKJOnpl4jI8x8jFdTOJ89l5Aj88oGR8xp+YDvj0tEA+XJxeH5siw1Ap+Onn8cpxSiAfvGcMiYvryKggDHPxhcc5tM7EDAxzGf906EWQzia0kz4NWvBflo9mFP+otMRQfOw3L0r91i2IF2tQWeB5NJqi0azU+tUY9Zp0Itl9P7LqmLb1opw7lrPZuUQGKQJZorDvOd6ul3ZSxcL9dD4d52OMddgQl1pQQ5qEUS4HFAAixtBrd/BxO7ZP8hZep2rRwXRs5mgiBM3NdWyuAnHQ/w/JYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXxo39ygzx4RxzGSOrbfZ8dB/yJd1E7ykLiyRUsovmQ=;
 b=U+vAXJPFZyCJtyI39AtSopDlID4gbx6MVNYR7f/SGE2yeU9NdY6r/bo3QTX0JKeckhY/5nzEwsKpXpvlgfNpRKYw2xtF8Y0amoQcQg1q4ft3P9S4jETdb9t+HkGaNi1jpi0PVvNmYuOohCPYFrSuf+pUxQ+ujhK5+rPMsfwJ7EVFirZU09GyyoO03hAmlRt0/b5DY1rnFfUbzIJPuaH9c6kutZ68TeUmra4xGrN0KToxIwMrQB2yzVo/dTH/QMgqD2xbFY+ectZO2WCZslElwntzXFBmzuKmA2YEp+zbNpuTh82hNzlCgv6oz1Z00eTcS5E8mfsvSBIqJYKt54Qxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXxo39ygzx4RxzGSOrbfZ8dB/yJd1E7ykLiyRUsovmQ=;
 b=DOhrAjgaoSVja/tZskPrbnLjuwVx5oMrZ3lm+OmSaTzCTC/+Nl2PKB/WYrU6WE0siF3pft5eiRcK69Ul1onZcLJ0cvdGaj80gVrXQ9JiGZ2gB3MZ7e9l4hKxHe6vMSVnnFwK3NMbwlfp5YM9nyvO6qDwjTRvuiZiFq+peuAPtd0zugsZ0JDXXvNxWjy/3S3cJAI5vEzJxDHCRSXkAhJNHlUNFUsLJMFvtxRo2fyJyzQMOAQUZsML2EucRTrFNm0OWl0vbwTzqQ+mpu46wIrqAFuPh0YlRqZmWRm4rdGlR2JUUAei1mlEhB12kSC2/nMEA8Gd//pKAAsdcN3d15wkeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 15:47:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%5]) with mapi id 15.20.5676.032; Fri, 14 Oct 2022
 15:47:13 +0000
Date:   Fri, 14 Oct 2022 12:47:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: hmm_test issues with latest mainline
Message-ID: <Y0mEgGjhtpMI7ndk@nvidia.com>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <Y0lPsbLKZakAGZeZ@nvidia.com>
 <387b3e48-71a4-819d-4ca4-4e83501d9791@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <387b3e48-71a4-819d-4ca4-4e83501d9791@amd.com>
X-ClientProxiedBy: MN2PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:208:23d::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4319:EE_
X-MS-Office365-Filtering-Correlation-Id: a672d414-1ef7-47ef-049e-08daadfb5d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KCCua6aYbBl9rwz30cDJBiCZtHYapUSSd8e3MH11VWDHUFKkdTW/dbGROeazuDfJwkDANNsXVjuPpgJ14EdXUpQmnba85uJMtDM/kwbwLHF6CbUleIs+uRxJ3LdmtHXvO1nmAQK1yosSh60OGWHd+4dSSVHn5Qcj6fgPk2PYw1yz96eAQa+/whZQ0Ybkfr8/aZ4O4rmWk5t9eTfrxkS2rKxWKIrpr4sHlWmDSx+Bcll17svhfXwpYGua2BitPha9KpIBHIRnTK8hX0lPJugaAzUf5867hhEz/hQTCFaVgrM7HBrVZJelYZpaaO6BiE1KGaa02ug7W1366OgLgPNZxEWlLUH8mdjwTIyM5O4/yRG7B4iO0e82UaHJ2lTO4VivovnOT384DyPaKJsGTGO/zQEBo+A2cgucyXxBxpz9hNHICNrGpv7gPo6XETgHgEmES3bej/Vd0LIbNZWUAqP6UU5s41srPIOWX6NrCmrZYruvssWVgIgMh5G4Z2+xOO2cVfMbII4PWD7tLKkML6iftnDug0Db166uQib1RIcKNlSROFIdonFT1KBsS2uePabFJrAC1M7rMQdz+CRwx8tNoW56w1jIu/t7juwjut26S84NXTV+ayadjgVzur+VwEC5xqFkWbvhfMyfkB22AtTreUnDGA/J4l//EIk1zhO72Hm/avt6gsgIhr6hQMkYcLQghbPX436GwI4k7X51dH6mtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(4001150100001)(41300700001)(316002)(4326008)(66946007)(66556008)(66476007)(8676002)(2906002)(8936002)(54906003)(6916009)(5660300002)(38100700002)(83380400001)(6506007)(478600001)(6486002)(86362001)(186003)(6512007)(26005)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XX5FuKB9QaLG9f42wRrHifv9nbMMLRKn+gjCKqmUnLg1tPv8/FP2WEduI5PE?=
 =?us-ascii?Q?jLUuBRlZTIUKjsWU0PLttChSj9YY1ULm0zOs9629OIIlNgqMO4vj2Ra1STTB?=
 =?us-ascii?Q?V1AWGSc/hqL+uubH2+/EyAuqlCi+iGf0o3IdZtHd1BBuQGdoPzJw8wc+OWpN?=
 =?us-ascii?Q?vepZEFPKquB5ozT5vk1xUo46dke1kafH6mEOPjEY1hGy+qNqGT5N9KQVox1h?=
 =?us-ascii?Q?4iiJe5jd/0T6FliFgjqoF6eKYqKGCTzDv3cKC3VhM4gSi2z7DX5qqBgy/6uT?=
 =?us-ascii?Q?Pybcm59XUEF+4hM8dciLE/JxvJqbqrNHcQCng1NZskFcnE5BTDsjBbytT4Lq?=
 =?us-ascii?Q?MoTfd2Bywkl8YlPcTcxtekkutds06MYnbMqGXhMLGmaxNRbJ1s40EpBcbKBL?=
 =?us-ascii?Q?v2OSv0PedxmhOXnvJ70gUd2EMAm9kdOW9ueZeQ9jKICzCXMLCc19rGD1pivy?=
 =?us-ascii?Q?MEP8YDg49A4s2mU9Ekfrd6gnWx/PK3aeZJQMs0lDTQM2+3EDhWlfHZ4W3Kgh?=
 =?us-ascii?Q?hNq8PEsmKrSDmXobyCedUlSuG5jpzcR8tCSowlwLz6LD7NlpnyM7cV5vszP1?=
 =?us-ascii?Q?Gzqvbu4nFMmy2jv0myB17aHHkuucVQqqJaG7wvLMcI047JEXEmIep0Pb8BMG?=
 =?us-ascii?Q?2vA+04F6jeV0TaoHVnj3ZnxbrZ9gwRb8bVtMNoDHnSMj5fL4CGc8XhPXmwa7?=
 =?us-ascii?Q?43CEPTBiqROgAd8YurQWufkctVOPITnj90B0c4LF88LvUWeJtzJhJjlWu6Sm?=
 =?us-ascii?Q?ZGoOP3nFoDmgE1FPuC42HL/Ha5875xouYn4SgOPt6jBcC2sYL5pNTWg3ZmiD?=
 =?us-ascii?Q?X7GMxUu8+cMF4g1x2BpvDB3bi3+g2qh0/HnvkHmXr8MoXFgfnNEwPEAbhRDx?=
 =?us-ascii?Q?aalF3UypQf+eXe4R5N0Zbx/MpZybTDbYt1AH5j1Q8Z727NYYdvT0KnRSwlIn?=
 =?us-ascii?Q?UiMSoUwzRVGUeUlwDF9We44FoYCZuSNfGCAJ2IQKnVTgih9PZYliw94iRyNc?=
 =?us-ascii?Q?7o7m6BwLWaKUq4I85+OTJq2h5f+rjd4kAcS0E3P7AMDA+SrParzsIk6U7Poy?=
 =?us-ascii?Q?2b3RXnampHIvvlf65nvxF/n7EFUvYKq/V/Sf1T/J7uCky/G52AnyroevEY/N?=
 =?us-ascii?Q?0wh9MsVRJWSWyyYi+Z8ObA2oPSQ2AN5n+Lr/D4V8GGxAlGyevGhTVtiFys5D?=
 =?us-ascii?Q?7bJwn/zRX6QQbiOWRgQgHVTQnfNzpmy+H1WZbIZIc3OhF+eo3AZ4+RiKjm13?=
 =?us-ascii?Q?zLDpEtDlN1IaI0kuzekn/NkGEC7ruWvivfk6oqVn/Y0/8Kof3ZFR10i6t72n?=
 =?us-ascii?Q?/PnrEqVMikTuLqBKCLnNUh27AoZ2hx8bCegggKk9vTYVkRZZPn/5UauMoKnA?=
 =?us-ascii?Q?MOVoOZxcNfTjh0dxKKu7faPqRSoBykS5Xi00WM+/VpSCu6L5pgSRxJOJLJU8?=
 =?us-ascii?Q?2camyJXBSjDK2DES+2DSz9WkoRXlKjWISU8S6OWM7XMvPB2FqiJBtKulEOcl?=
 =?us-ascii?Q?ouGJhOj6YUGU2fUQvjjBgdis62AehHc8Y9HmwPi2Y0zKM4NdgRu7Azy2wW41?=
 =?us-ascii?Q?R7+l8dGgSdEbWKmCMgE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a672d414-1ef7-47ef-049e-08daadfb5d07
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 15:47:13.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPJvUyx/X8phyH75j7xChm4IYbGNSRS1vRL7hGzzez2yKC46cO63Au/N4O+VrYjQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 14, 2022 at 11:03:39AM -0400, Felix Kuehling wrote:
> Am 2022-10-14 um 08:01 schrieb Jason Gunthorpe:
> > On Thu, Oct 13, 2022 at 06:54:24PM +0200, Vlastimil Babka wrote:
> > > Hi,
> > > 
> > > I've been trying the hmm_tests as of today's commit:
> > > 
> > > a185a0995518 ("Merge tag 'linux-kselftest-kunit-6.1-rc1-2' ...)
> > > 
> > > and run into several issues that seemed worth reporting.
> > > 
> > > First, it seems the FIXTURE_TEARDOWN(hmm) in
> > > tools/testing/selftests/vm/hmm-tests.c
> > > using ASSERT_EQ(ret, 0); can run into an infinite loop of reporting the
> > > assertion failure. Dunno if it's a kselftests issue or it's a bug to
> > > use asserts in teardown. I hacked it up like this locally to proceed:
> > I've seen this too in other tests, it is a kselftests bug/limitation,
> > AFAIK. You can't use assert macros in those functions.
> 
> I vaguely remember looking at this when I reviewed Alex's patches that added
> device-coherent support. We wanted to have these checks in the fixture setup
> so that we wouldn't have to duplicate them in all the tests.
> 
> I'm not sure if I missed it in review, and Alex missed it in testing, or if
> this is a regression that happened more recently. Sorry for the trouble. It
> looks like Alistair already figured out a fix.

I think the design is fine, it is just surprising you can't call
ASSERT/etc in the fixture codes. Hopefully something like Alistair's
fix gets merged.

Jason
