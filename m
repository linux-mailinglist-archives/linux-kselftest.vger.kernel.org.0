Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3491A62CBDE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiKPVCv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbiKPVCE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:04 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440B183B2;
        Wed, 16 Nov 2022 13:01:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORdSFKLmjti/nJ65Rh9R1fkLzU2OnzxsCvjKjU65g5prMU/e5RUlophAB//Z2awlDJaHyLwr6IE9TGgnhM9vkw7wuUDIm+grqxczu1CmPwl8xoFwkL0KwQOqryzoYQMckhsMIZoKmFDphkfIOWOrdBQliUwziDDWXyFiTZoQkgOaiK6SSANKNcR20K/8o1GkR37bTku228z6C9X4TldDDx1db3V/cG91ykzRoBlGsxlX7XFaRcUnlBB15Hle4C8TlpwqM97cstIqFb9DBi217s+MPpoMQ2Be4/A5GqLmNAcEzAVLT4E/mkQ28MkpWmL15oIpJVOyK+USUD6x/IlG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fg/y5XOISbY7aMh5HOd5Q23eYMEF5jQCaqyUIS5HYoo=;
 b=Ek2RLm/kUXXuxUlV3/QSZGdAnBMGtiIHFSsxt87USoxLob3U2BIr6pxQ0OQ1aBdDRSSxwEgufkA57QaQA8x1hOFKKa3pKK4AQBCjdKyX//sXQEFz7DyMKQvV0OdBeeE/+a16YY/TSlYAzs2ArdIBSwW+9vqq5mje9lUEOVGfsjpGAOX1BFgZjJwTR8UwLYO/daUs+0c/Moqok3JePW6Pt4WTZPt0XT8+exPNqPbC/31vWL9JE0pYx+Gl+TiDRi+lFuqTpGb1rfDMWqhYzL3iN6e2x9c/mNm3pddxx0QFgLCYv1dAooP9NKWSRFJ7KZ4i7EpjQBOaRaturlI+nbtSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fg/y5XOISbY7aMh5HOd5Q23eYMEF5jQCaqyUIS5HYoo=;
 b=D35NXJyuDC8eMpB7jV6dnRpxMYGzfZzOAzawuLpuAMnFuLswFJWIBnN0Iqh3/EkWZnwyqOg5AkhUTO8k1tWaRq7r0LU1hxIpRI+yn3GZBeDOjkqbYONgLY+Xi0RYK74O42dzkxvEv9xmOhQl8/YUW/+GkI8Rn04+3VZMtkoub1ikWMADiiqyIe8p11afw9usyg2pQJwdJaXEEKp/cdKkcH4xBFID5Sh1CvJicrU7P0+J2b4+uittvPuFx/Dch+NzuYqg+yO0pfONe8qJ255MQRclW+4ElfNMESF34Dcjkc5+9PoloXTg1HnrOiZAFn+NdBmcJZ48hFVeG1ecsqYzug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:00:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:00:59 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 04/19] scripts/kernel-doc: support EXPORT_SYMBOL_NS_GPL() with -export
Date:   Wed, 16 Nov 2022 17:00:40 -0400
Message-Id: <4-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:208:a8::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: 628bead4-e55c-427b-23da-08dac815a886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2nnjXJSxUsBWIEg/W4DAY/+Ij2Q+b0KobNNDZwNzvv4kfocsNVegnwjSsgat/wetL8IqOJhT7FnptFGQ7fc5uQj5MY/iqCmTVpP+QbtugL/gr1QfTc/a+q8Z/db8mZVWav7N/wRHydhV1IACXJbhcSls1YRmNqmyTcAvJZIHjzxtM2x6yPSqDNLuhIjU4M8ZhMSadN1yOfVADY4i4LU2VrMg3zb/G9Zdety9gSOhBEEmcxIBELeMqmmj7FDX04IOu4yjr1twFb5KgPmZs2hpyLckh/WLirXWPRYdQBKZu2tqJNQHT7zK+yYW5yvSyeo4UIMHY7opW3eeEiVOOpx4SyptpUVeKKklYAZzQxdRY+TaDoGAewUJ2KzE592uuOoLWW8Gnsob2Tdzki6405a2Lv/uFJTOZv/t8SGWa6/MgbdG/oJuxNx/dYC9g/mH6gCruNKiGy6NdFB03u3BHLYL3Sxua06zVMTI2qHOGoz11yb81qUOKmZjvJkBB+4NLFvq86m9wkK8uB8ErG9dUE0czzpKmYmUvtkteeW2Y4UFjFgtAyCOrbVLD679yTSD7OBNN4vPyDyybgGN2nK2WdPtKk+UQO8rg9URvyUS0Duobu1yLA5GInUBdgqDsHU+YQ5z43ObHflrTK3PBi1VJOGBTqWjxWgojSot7EEYt2iVWi0rmpg2hmR9abb8rmvex4Lr8F0DUd8TcXR20ITUrA+5f94SUJgNiOrY5/VlIl0GtIKcAjrhyPU/we82CEqj5RK5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(38100700002)(2616005)(86362001)(921005)(110136005)(7406005)(6666004)(478600001)(6486002)(7416002)(8936002)(66476007)(8676002)(4326008)(54906003)(66556008)(66946007)(316002)(41300700001)(83380400001)(2906002)(6506007)(186003)(5660300002)(6512007)(36756003)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v6hOb1svaYoAXScIw4U30A3HdORfNIiKhyiJ/4ZYYrdt+vqlVMquGCW0wuou?=
 =?us-ascii?Q?yQ0qzHDVAMRy6izCwi/n4WzkRdpxsYH0k1MAHNZMCvbmNXuHzw5i8KKbP7YD?=
 =?us-ascii?Q?3gf37jqTmDukGd14j1CjKjeYq7DJdsWE79pj+pNGbd4K1n0aj6tPKhemhk/P?=
 =?us-ascii?Q?c7Bevt1fzxF1gU8RhOlnx5UBnMYQQ6Q39kmYkyhQIbHrE+VP+FwYKTrYrzzF?=
 =?us-ascii?Q?40bvFyZPQh8iJuq8gkNNUQ5fImL1anvrU5DprCiqtuqn1QMOc+grbgXqUKJx?=
 =?us-ascii?Q?H4T5KmYu5rJeBahiHoHLtWS1J0Pjfl2CyF77GxsWzoUflxoHdlreUdn2JCyk?=
 =?us-ascii?Q?TIQIszhkBJ0MGITbAC3iIXgxkv3iOW52hwWnq2e/61MHpWoIFhN2GwNY7POV?=
 =?us-ascii?Q?ic2l4JsmCDmNfKNdpQ5WMytntYHX5r8K39D94xbwnKuYw9awiA7wgur3NNSh?=
 =?us-ascii?Q?9eHwtoWTqcK8Y/7BMYZGih2hBEVhdkTeTxD662K8/f5UiMTRQlUxJEhDyYIg?=
 =?us-ascii?Q?M50GgfOzz31IgOSj6zY3Vxg/wjpK8ZILnecIUKcMInv6invd09EvPts3DPjY?=
 =?us-ascii?Q?Rrb3eNt4UqIX4DYTNqpybKatOYb+c0uL/mLZp0UPFHYFXP67cyQ7H0RpieG0?=
 =?us-ascii?Q?jRlrdbmMu9Y5DzfDDFdcCdL+4va4C+AFDeBUYX/SBsudH6RxlzH7V1dTBPIz?=
 =?us-ascii?Q?cAdR7dFr0w192CGyaW2h62Y+0dQx8lz+qA/t5KY0t5gyJeuWTxjcO0jR0l3L?=
 =?us-ascii?Q?J/CbZWPerXegk8/nHOoNDbyfTxjBEY+zcJzPVBO/ZUds88vkUynw/xcGNKtm?=
 =?us-ascii?Q?tn7VrxFifiqqWsTJIttUw60BND1xAgp1hBpfCR8EpWhLljBiBKM6Tw1YT3OZ?=
 =?us-ascii?Q?bCK7n64Ug//ygPnNug0IMXWlQt3oZRJKbidYYY/hvkGAixIVJZHsRXBP/G/T?=
 =?us-ascii?Q?e0wmRMWSXERjJ95+ARzHjqBeOUTDXD0oS2B5tMNV1YFM80awCm+NGmY8bZRV?=
 =?us-ascii?Q?L7oxHpiLKMiM2IzLtA+BT/CZAP+pTXJOB7SGHaLBe0HnMUdzNOOi3EmXlq9p?=
 =?us-ascii?Q?WGST4caStplrTJwEpO4ySK6Mx2fBnNqmFsNTSZZuenK5GRipTg4oGMetAPZZ?=
 =?us-ascii?Q?W1XBmjHFBTULUnHdnD3tHq+keARlY8BMVtub30LXeBGz9vBJeW1YDOj0C/LA?=
 =?us-ascii?Q?0VOS4Np8PGlBYXusiL+Rmyf2WEbQa8MOmpyq8MccgyzViMgRqxKsOr7oEokI?=
 =?us-ascii?Q?CCIENRdNLGE+25aIjjp1h8IzElzl/ENQ2lGvlYzPEr317FQMKzW3/S7uEhMu?=
 =?us-ascii?Q?BBJ8TD49raWv2/GLrtX7P9Emm/ZjewfzR1/Dqvyj9uasTyov6O5PbODBBjlU?=
 =?us-ascii?Q?Eb5UF7qFP5txTqokUhTdXsbjJc7wqoe3gaMaCsTr6iDueSNTxYKOXO0sAeTN?=
 =?us-ascii?Q?EJHFpV2nXFzl0ZAzpJSvGFq6S+u6lu1W5qCv/c7w6NasIgF2twvB7NTl4k1U?=
 =?us-ascii?Q?YCADuTJ1rkmGHljAfg0Zr30eRT+eoUU+pQ+0Fq55J9Qj4JSU6/nyEgTORF1o?=
 =?us-ascii?Q?iAc8yNSODjgdK+XdizY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628bead4-e55c-427b-23da-08dac815a886
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:57.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEl6hSssGvufSE65iCFayI4VLq0tvlhOekKMFyzARBEecMXyYj+op7ISDTGsqF3M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Parse EXPORT_SYMBOL_NS_GPL() in addition to EXPORT_SYMBOL_GPL() for use
with the -export flag.

Acked-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 scripts/kernel-doc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index aea04365bc69d3..48e3feca31701a 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -256,6 +256,7 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
 my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
+my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*\w+\)\s*;';
 my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
 my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
 
@@ -1948,6 +1949,10 @@ sub process_export_file($) {
 	    next if (defined($nosymbol_table{$2}));
 	    $function_table{$2} = 1;
 	}
+	if (/$export_symbol_ns/) {
+	    next if (defined($nosymbol_table{$2}));
+	    $function_table{$2} = 1;
+	}
     }
 
     close(IN);
@@ -2419,12 +2424,12 @@ found on PATH.
 =item -export
 
 Only output documentation for the symbols that have been exported using
-EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+EXPORT_SYMBOL() and related macros in any input FILE or -export-file FILE.
 
 =item -internal
 
 Only output documentation for the symbols that have NOT been exported using
-EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() in any input FILE or -export-file FILE.
+EXPORT_SYMBOL() and related macros in any input FILE or -export-file FILE.
 
 =item -function NAME
 
@@ -2451,8 +2456,7 @@ Do not output DOC: sections.
 
 =item -export-file FILE
 
-Specify an additional FILE in which to look for EXPORT_SYMBOL() and
-EXPORT_SYMBOL_GPL().
+Specify an additional FILE in which to look for EXPORT_SYMBOL information.
 
 To be used with -export or -internal.
 
-- 
2.38.1

