Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0716E985B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Apr 2023 17:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjDTPe3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Apr 2023 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjDTPe2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Apr 2023 11:34:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143141988;
        Thu, 20 Apr 2023 08:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma417743dtsDmg2+T0tlDXCr9Lo8Oj1McB+SwxdaUe1yPAQL9yv08lsCveQcE/E32MZfqKyjKz/IymhU5ArOvEoEPxTgGRCrqvIo3jmd//M/ML3zzvlBP4tI5X/Bx30gBduaRTxxQHSOnSIIRaLRgwD1Lqs41CLM2LMYiW60ZJgOW1bEggH0PYOQ1ASRM2uhqF5vEOgHB4QDDQNEZfugzR+VISOqL58hgY6vr9DzIE+dYSW8ui+cT46Grk233fm8+2mq443iKpuQU1C7CPWGyjiQTile8pWuHLtiKWz7jeMNVEzhWzAVHohR39V6Oec2d7m5lJnOjg2JD2LQXzaWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7NY9YplT3wWg4WzfOkXA5Ow2s0RE5Vz6nxAbXENYPI=;
 b=XKPJR8JWn/mGBdupxlSnhgMhQZTYLgPKwVm5szU13DD7KH2beBYjdeczRZil/sTJ9lJI+mX4Dn9yU4WjF4aywFXZDDkhaH9xa4ZmZCWVi/4snhkm4tVg5yn62lKw32+LAAeBZruxtsmWa5k2TmiJHRh9P7DRCNIZZSC5L0tx/bdKFkCGAF1FcAKunJCq6WIvfyLuqpUhvBK2x8T4ZeF2tDR88sl4D2NG3dp6g0wQJG9Esehai9AKQaN5rqEQaFXE8er1AYW+mOwgL704LVyV0P6h0DVJlromSSLqXcE4uJkwtwQC/lHXI7IuqJgowoNJwKG39aTkNg5PolQRiF0BvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7NY9YplT3wWg4WzfOkXA5Ow2s0RE5Vz6nxAbXENYPI=;
 b=nDzNY87MaLMudAl+qw9ZCo5NznN0vc7Ozune44qfAy2lljSDinEjc2WN58VKuEaieHygS/IvhFdRcMAoJE3vrbKhHZtAdoAthHrcOt49PhDR/ET0noBdfUJuRzppHMjFJRCJyy3Nk8dGDm3/cMdGzTlLzfmDEWPFeXFc9pXGCFP8YsCyw5lIbCgT4eOXKD1leW5YgpuNY1G4+K6xvsBK2qcB+pNOqgmJUK4Z9CMvaZyX6Ip1sl96IuiN8JNSUFj5cSgH/2cTeaIZVT19Vkxp1QjEyTeqwi5JU6G+pJJGvRCaOlw9sane4bbgHLquyWy1TfiF8Cffzg0YWJ6pkI0DAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8010.namprd12.prod.outlook.com (2603:10b6:a03:4c7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 15:34:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 15:34:23 +0000
Date:   Thu, 20 Apr 2023 12:34:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZEFbfY/88a4PZ2Ny@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDVvLbSN2TR1Er1c@nvidia.com>
 <BN9PR11MB527661A29A11AE1E7FC655018C9B9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDaTY6OX8oR5w0uV@nvidia.com>
 <BN9PR11MB52762841AAA04A24F76A743C8C989@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZDlVtcwhV2G8ZKao@nvidia.com>
 <BN9PR11MB5276DA68C8318CC3433252CA8C639@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276DA68C8318CC3433252CA8C639@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:207:3c::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d20ff24-035e-4172-73a4-08db41b4b6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: un9Q0bLkNsp9qlFbF+BAX7NAoTjBbUEuHolXUi7NdgJ9lCp37fBiz6stPuMV/mx8AIwbqFtp1oVCS7Jb1yF74CZ82zDqvTXqBMZNbDIH9TXE7gHh2yZcXHIdq4Z/oIksIwja/k8jdmyGYu+lCigyRHLSSZIJGRcmJb4ilRRr0u/6ARM0YhAuTO6qujVnp8/MQuo8MLi54osnVcwZgsLRrXgVQlHyOhGadjeC6xsbRGKPgnJpNJRHS35xIPFGH29AmxAxQzrPXKqOC5WVGZLF5lQxZ/hwqc4DHgGqDVWPyYBVmEFy/pIeCSzShQxXWQ1P1LBYnhe3mSgQJMzot28ouT9UCZi76PY/keVbwSETA9yV+oz8ODhipAlAtD799teNxaHovJXgOKV6o/CnerpBrcEMb30FAAbif8fNO274XHE8RsgSBFgSpnlfBl3xHSUO37S2lY6YVFUvboQouOXLs0m+qL2Z38UaXlj+jUI1cdjloMIZn7eO5/ob/TfQIhlpcMaCFqsWlP9yHejtuE9d/LvAx3j4e46/w1vh6+FM8MLj+FNJqV5XcUhVvjrqMD4B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(26005)(6506007)(6512007)(316002)(186003)(41300700001)(478600001)(6486002)(36756003)(54906003)(86362001)(66556008)(66946007)(66476007)(6916009)(4326008)(2616005)(38100700002)(5660300002)(8936002)(8676002)(2906002)(4744005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGWw2/f75U8trl3OqhciCt2r1vnOLn45YB7/o8MiDOyiZXT0OqbFift6PMUe?=
 =?us-ascii?Q?GOTdv/8sOAtLrYtupCT4Jf+ri1l3CPszXyVxaTnINdw3JhPBXffm/C21Qdua?=
 =?us-ascii?Q?/uArocAXDhnINhqFSO6q6OIC1dNEZnwXfSzo2okm02T4BG1HpSdc6bkqzObL?=
 =?us-ascii?Q?Eoc2ocw9H9M2srii5BKhmx/o7+GNOAdYU0X6jtMA2TT3mRbXgdQ4YqIdDSSL?=
 =?us-ascii?Q?ozM+yAsq8myzK7lYEU54KV8eV/yY3ofLBizy4PVWFLibZ4SBxrNNjwPSx52r?=
 =?us-ascii?Q?XkVPV/IA0ntg3HeUVLuzJG+TmhQBbefJBBisxHBf0gKWtysbhmV6bpvGS3GA?=
 =?us-ascii?Q?fJlwnONryag+VNwdRMC03ZUotjLqaXYj9Uydc1rf9jAplVOSEWby7myqYDxv?=
 =?us-ascii?Q?/ZJaWukKLSGq3KV7GJrSz2jeVvIpL5d+IizM4x4fEo86mBkEoLgTm8sYJnkr?=
 =?us-ascii?Q?zRdwx7xgjMLth/0L+ZLYuMnkDJQ2TOpLYWfQ5/owDUPqM786O1AT8PeBUq/x?=
 =?us-ascii?Q?JjRwMObwswo8uJmIiF57z7GPNaS2/DDQgH4sKl8ME4K75AiH/J7Z8khAPuX5?=
 =?us-ascii?Q?WrUR5vh2F+xjHDHsr4AnrY2mxOK7Rpg+xaHIWtI7ba9hDytzd3jUfotbrnK1?=
 =?us-ascii?Q?uJpM16TVkqTgJD5cx0XmG2XNSCrfHH5xv/fTjo49NuacS27YHCUrS56Nh575?=
 =?us-ascii?Q?qI5z62hvswgq5i97/wFlZnO3U0xHWjoIjOJqlaJHp1Ci6Co3M8hJgk2K0oR6?=
 =?us-ascii?Q?lZURwqwF3S0C53e3MKctDpFlfQCusIg4eobOPtrhfPqzWUcriaFpEXfx2AAO?=
 =?us-ascii?Q?PMusbn6BGKqyuK4IIR0Xgx5WX3VrTLCT1IYjrIu4ga4+52OhxzYE5zrj5Xkd?=
 =?us-ascii?Q?XUM+cK+EHHYq9T18Lol6zsGS3enJxmfW1gWReTfPMnnP9x7xn3RDqN64maoz?=
 =?us-ascii?Q?1XZL/kYzLo0oLb89ltS+TqiHXToy1j3gGWcbVnx2gA9Huscqbg3nxN/3oPEY?=
 =?us-ascii?Q?iVIU44YADB34rn8dpONBkrKT++JAwmoOnzJqU9lgqgGvlyskAZW+jRcDYYcW?=
 =?us-ascii?Q?Ba1Id1/tk6ngLLZDVNhttGiIYqENZD8ZEEZkaQXCaT3hXl2+IEjr8/P1FKuS?=
 =?us-ascii?Q?RUdx3ll6BNr4YOKV3FCy73WpKuivsXbmE8fndaE3Sf1buTorFTQoIL50OrUh?=
 =?us-ascii?Q?/jZlPExtvHdtos+VYVtrPUwwH+5na7GW99BBDAtiXkPnrslLqKQj9z46xp65?=
 =?us-ascii?Q?yM94YxPUHYctK0991dYNgexiIJogYEE5i88B3DDTtjq6T14BkVrfHzXaPe/9?=
 =?us-ascii?Q?rXlsshbu7iOHuXzDaFiqF5Zei9+LlEzEsvq2Qwxxn1WnrxLDO4yWHuIBL+hL?=
 =?us-ascii?Q?fMRTQ79mqWNwUl4zmVwtv/xdocfcPGK5yzBFwuLfPBpc5Zs/az3C76KwlqqA?=
 =?us-ascii?Q?yMnrcWY5v0zrRYbBiD/MethJTN8eGRbKW2SF3G6lHIciujFZoXt57FDaoer/?=
 =?us-ascii?Q?9QSM1DtpzbRB0LCBzVkZWMIgKfJ7kTKcZcWd8PjYvQN5JHCoQfNdXLpC9dXG?=
 =?us-ascii?Q?lSUDjObbwzD6LEu7+vUiAwsADaGtEwz9q+9ZGFBi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d20ff24-035e-4172-73a4-08db41b4b6e2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 15:34:23.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DvFEWkCXElkIwZA77i0I3dnmtqC9QXEwP8Mr/ihb45fUy8+41HgmaN13jWc/8ub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8010
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 20, 2023 at 06:15:16AM +0000, Tian, Kevin wrote:
> > > which internal list? group has a list for attached devices but regarding
> > > to hwpt it's stored in a single field igroup->hwpt.
> > 
> > It is added to
> > 
> > 	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> 
> this is called under ioas->mutex.

Yes.. But.. that is troubled too, we are calling destroy under the
same mutex, there is a missing a fault point to catch it in the test,
and hwpt_alloc doesn't have the lock wide enough :\

So you want to argue that it is safe to do this:

   mutex_lock(&ioas->mutex);
   alloc
   attach
   detach
   abort
   mutex_unlock(&ioas->mutex);

Even if attach/detach lock/unlock the group mutex during their cycle?

It seems OK..

I don't see any places that Though I don't much like the locking
pattern where we succeed attach, drop all the locks and the fail and
then relock and do error unwind.. Sketchy..

Jason
