Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E899F7CBF54
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 11:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343607AbjJQJ3r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 05:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjJQJ3e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 05:29:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDFE19A3;
        Tue, 17 Oct 2023 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534933; x=1729070933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RL1aNBhAi8Of6uCxhRzuiehyjjf7OYTMx2EPf1bb4ZE=;
  b=AOJH78cRtuIscMgk3GR1cUyacCGQp35+fMC0ixACzceU1eon2+9qwwnP
   jZmx6Issa8KZGX0gz8BfbE1JcuneK8CaQzSh8tQ1EO434yW5iRIC1xAeE
   2oaWT2MQPlTEu2hQvMBo9Iuv0C68SQ4O2rVUx+UsPpN0R4ALUyV+zyW0f
   F7njzo2cShnA1fZ/8zNIPesYstRV9OHvpP/wJmiUKNNfajbU1D8mWIIKk
   w6jfkytRA+f0NVe+h8WwQv4UtihZ2HjIgkg2jC2SI1kwMq2ipetEAklii
   yp+tpKstTgqRcFPeU4BCShJMooVK/MQ0XDQ+SCKExRtWw0SNuH3Aq+1Sy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="471964695"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="471964695"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087436189"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087436189"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 02:28:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 02:28:51 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 02:28:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 02:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+odTH6a3X4t2mqX5UJPSUGllBWpcyI3vc/IPdnjyhiA6rZ279uQOwfaK9hfyJ/wIGOoa0iVkw+Qjfr1INyZD01sgzvWRksYinmWnw8hycsj99fnRegTPLGbkrLT0wAgsdliPaXxaVdDdIsP6GTl7NZ3bn/LLW+B85L10azpe2VsaXi18v+SKYuH09z+VIMfSLm2Wf8vZFmHm+aQOZ/o0CU03q2/KJfnIVsdAGIfc6OwxSnGn7NnCUUzkZRZDWVGLZnl4bGLgBmRt1tEhOsKJC6nZT8O87XNvhwHvmkganLzoDS1ZaimSvkhvV5lkRQhd0v4NdDLOluOuOTLJOjpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RL1aNBhAi8Of6uCxhRzuiehyjjf7OYTMx2EPf1bb4ZE=;
 b=Mn4u2r+tb/+03rr4FzY2rBekirIzWJ6u4daE/1i9OiBcNhuImgeY02g8HwUxYv+WEXUXwcxb82NzTml97AjsUKnKKBHk98RwwLsF1zFs+OhrPw+zLUgBTPFQVFbHMdBZsdXATn6Rkhn+BYBVV7bdaP/gHp9kTBImspkI9HuLkhl3m6Udh7fUDEw/9eHAha0uQ5T5RZxTZOioE/vt56flTR50DE8WmXYFJbeI71qHC55PAuNNgWml/ja53tej9C9J++iIavY7+/PZdrgHwCpuOttIK1mvs96s9qOKgCx6dts9ZAAR+B/D/jCif2EV4JSsWL3dQCGPB1mhqlQS+COQbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5335.namprd11.prod.outlook.com (2603:10b6:208:31b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 09:28:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::7116:9866:8367:95b4%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:28:48 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Thread-Topic: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Thread-Index: AQHZ7GCQqMA2D6hFIkG8of68DC8uNLBDXUwAgAKiBoCAAErqgIAA+cOAgACfvQCAAEDUAIADxEeAgACNVoCAAGs9AIAA9B4AgAAJZrA=
Date:   Tue, 17 Oct 2023 09:28:48 +0000
Message-ID: <BN9PR11MB527671149ECD3DF3696A39988CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com> <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
 <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
 <20231016115407.GO3952@nvidia.com> <ZS1+VMEo+0bCecui@Asurada-Nvidia>
 <2a86074f-94a9-667d-6e94-c582d49b7588@intel.com>
In-Reply-To: <2a86074f-94a9-667d-6e94-c582d49b7588@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5335:EE_
x-ms-office365-filtering-correlation-id: 9fe81958-5622-4b54-8d06-08dbcef377d3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /guwPkzOxIvmv+LbgkSL0zg0OivaDD11FIpDKWYOg23Al6ZEhiqdU9STL2Q6MrZEPQ7PQ2J7/HaVPiWiGeiwVQc/iLlsFYaXyGAkH1VuDBO9b6HjZ74X0MHUpb8fslizZrd908j1SQrXDDPTJbHh9GlektbXaDE4ddYR821MrRoO5SXTnwqL0l2zV5S9piYuegBnGBTK8q3+gmPmV5b/8pQ/Rj8I7q20vwwWP7RRiZQtjmEVus8wUflAc7Noe7/Pixz5+Pe/vbgsrHqfhvNbv8Uf0czFfbCb30Dzkc7X3da3PuaA2S+w6CROkggxeTyQ8LeWFxNLfg2M+IGH+2AazGbiZLEb0w+Fy6rGqSgP3OQG2EHQAgDrtXFC8CCMw7VmLkYuB5WgfWq1TSMEErDqSltmkyT4bEZaCl1U+tWDnHCWXEU0zuYzOcYyPTReJbkJEySqiSBQozvreNGXj/N1yo5fWdIZHaQEa3FmGdfJbGsv8TqKQL1+pfGniS4vTF6cjsUzlwNnu5Q50pnnSr2TyUYsDN9xFLoEcWnmgqz7KdML36zGfe33ZRw6nGtlgxjeGzIiIHSpJTvZJJPfY6ZSyBLfaEEqkqy4NO6sGG60ZDx++nhpyecdlmNZW8m19Qun
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(33656002)(41300700001)(7416002)(55016003)(4326008)(8676002)(5660300002)(8936002)(52536014)(2906002)(86362001)(38100700002)(7696005)(82960400001)(26005)(6506007)(53546011)(478600001)(38070700005)(9686003)(83380400001)(316002)(122000001)(66446008)(64756008)(66476007)(66556008)(54906003)(71200400001)(110136005)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTU0VUtpaDVuQ0xnT1NsRkxBRUpOT1FaSTZzWHpsY1FwcUVsc0l4cmFmS1BI?=
 =?utf-8?B?UExMbEdCWFdaN3g1bzJZM0gxcDAxTEJybFB2eC9XZzlTclRKSjZYQnp6dHg4?=
 =?utf-8?B?RDlVeW5maTBEWGloZGNLU2QwTzNzWGNsZEJNWWFNeGY1T1l5eUFIbHVZZW5P?=
 =?utf-8?B?U0crd2VhUWE0QkpudFdtN0tyWXNWM0ZpRGV1S255OEE3bk56cHdGNEpSVXht?=
 =?utf-8?B?UE1EMDZNQWxpeVdkeklNajNNNyt5ME1mTVNXSWErUW1oaGhCWnBNNHpieTF5?=
 =?utf-8?B?SmEzMDlBUFc0RDZvOVRnOGd5V1V6Y3g5cjhHM1djRDdJV0ljNkZ0dWtSZDNn?=
 =?utf-8?B?NXlaWVBiYXNCdEdZL1BPcEJFR2VlMEV0Vm43V2V1c29lTHFsU2JMOVpQOE53?=
 =?utf-8?B?ZnVJSWNVbnNTbXRJVHVOMXhnS0NxcGVTSDBsYVRHamQ4VW1TYXp6NlRKNWVx?=
 =?utf-8?B?anZHenlnb09aOFgvdHZhWDVBUnJ0d09xTUI3eW5IOXZFZWhJbkJTSXFFTkpz?=
 =?utf-8?B?Zmo2U0hKVEt5V1kxSUJvUmFWVnhuN25jOVNwWFZxaXhKaEY5ckFDZEF4KzVm?=
 =?utf-8?B?ZFVWZWVoamE0SFUyanl6ZW16TVJaMzY3OWRsbFFYNU1RZXMyYzJYb3BsTTBJ?=
 =?utf-8?B?MWdBZmNSNytXSlRidUttWGhkbWNhWnZFck5rTE5rUk91bUVVa1hINnZLeDds?=
 =?utf-8?B?bzFiWHVlNGNzZFJHa0k5bng3WWErYW9lU2VIVDRoWWhmSWFva1VFN3l2U0FT?=
 =?utf-8?B?SC9waDBidGd5dUJFNTN3SWg1NHNybENOUFhtSTJUdjNZWE5tR2Q3Z0R5Ym5n?=
 =?utf-8?B?NS9GbmhvQU9UZ2Qxck96a2ZYRFVnNUNDNWcwbWw0b01Fc1ZXQU9FQ0xaMmdR?=
 =?utf-8?B?SG5rbjJyQnV4enllc0x4TDR2RVRoRVp6WHVyY2FuSk1UeXlRRXUyZlg1UU9s?=
 =?utf-8?B?NGluWk8rTU5EZU1CRlJpdzJpVE81WGxIYk1vVGNTSTVRNmRiYjYrR1F5bjFK?=
 =?utf-8?B?QWdlYzdkRy9QNStkWlFWSGUzcm5uQTVaYnZmdzRXL3dZVC82a2tWc3FYa2Rx?=
 =?utf-8?B?SGZEbnJWMFhDd2tYM3QrZDBzdUVtbXcrTzZUVHFCZ1NBWTVpSTQzVlNiakhl?=
 =?utf-8?B?N3V1K2FzZXNKZjUvL042YlM4aG9wRmk5Y0NTTVNZK1hlNFA2NzRZSVdBWjBI?=
 =?utf-8?B?RkdxMHViQmw1QnNMMjY5QkNMS1UwVFJraytXUmtIRGZDeGdDUGQwSWFoL2Ev?=
 =?utf-8?B?RTRSQ2pqUG9UYmpMb2Z1Y2NtTmdUbFR2eCtJRkFzQWdHd3BjTUM1VzBUQjBH?=
 =?utf-8?B?cFI1ajN1ZkV6RlAvR1B1TzhoUlROM2NDTVBHdUViOW9rcnVJU3hUMCsvLzB6?=
 =?utf-8?B?clJyQm4yUmVKMmd1eDJORW1QWFh6NVhIeUpxY01UQk9rc1d6YVJ2cS8rOXNU?=
 =?utf-8?B?Q2hUTnRtbC9hdklxU1FvaSs5a3IzczMzc093dHJjRURRN2E5MndMd2NNYWJ6?=
 =?utf-8?B?cllpai85UUt3ekNMaUdBM1ltUWJaaG5JZkplbWk5b21pRmdpYVF6czFvL2sy?=
 =?utf-8?B?TFdGN3N4M3lnL0pPN1BGODJOQmJFQ21RU3Ird1prWC91VFc1U29xS3N1WlJm?=
 =?utf-8?B?akgxV3J2RFVGU0pJWnBaYzdoN2w2b0I0alhsbVRDUUtId2FNcEpqdmZwOFZJ?=
 =?utf-8?B?QzBjemdzNTVWaGdubHhSK1FwTDVZYU5YU3ZicGE0VGVJOC9hQVBFcXFIRmxx?=
 =?utf-8?B?S09aYWpMdU9lRFQwNy9LY1ZqWEttN2lqUi9jdkpUcWlrS21EWUNRZWx0blJi?=
 =?utf-8?B?TG9hMEd5UmpWd0UycG1JOFdmcFN3RnltWFlHSXNTbDRPNzZTbFVWYnhzbVN5?=
 =?utf-8?B?NU1DM0ZoY2JDZ2dQdS9VSFZwRnpNLy9KZFpkVDZYTXMxVU9peDJqOWFWU3Jr?=
 =?utf-8?B?NVM2K2RxdTliYzZUNWtGQVo0a1lydjR2bWRhclBtckVSd2FHZjlJMmUvbDZk?=
 =?utf-8?B?MUJjT09XQkdrZ2IyRUt3eWVIN0VtelJCZ1dCV0FleFZjTGhnVU5HeUZpNXM0?=
 =?utf-8?B?Z0k3SCtCNFR1clNWL2MzU2E5eGVSd1JVMHRmWmdJMzJYdjBFWEhsODBuaW9h?=
 =?utf-8?Q?img+AhsISu9rLUyiU0yCMPf/c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe81958-5622-4b54-8d06-08dbcef377d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 09:28:48.5336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Knx3Y7Yogpe6OLjooQYwaktmIGUk25urpujw9ITd+Gu3ZS8iYZhbD5He56x5VR9n1MeVcvXXck5pZLqrn6csRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
T2N0b2JlciAxNywgMjAyMyA0OjUyIFBNDQo+IA0KPiBPbiAyMDIzLzEwLzE3IDAyOjE3LCBOaWNv
bGluIENoZW4gd3JvdGU6DQo+ID4gT24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgMDg6NTQ6MDdBTSAt
MDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+PiBPbiBNb24sIE9jdCAxNiwgMjAyMyBh
dCAxMToyODoxNUFNICswODAwLCBZaSBMaXUgd3JvdGU6DQo+ID4+PiBPbiAyMDIzLzEwLzE0IDAx
OjU2LCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4+Pj4gT24gRnJpLCBPY3QgMTMsIDIwMjMgYXQg
MTE6MDQ6NTZBTSAtMDMwMCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiA+Pj4+PiBPbiBGcmks
IE9jdCAxMywgMjAyMyBhdCAxMjozMzoxM1BNICswODAwLCBZaSBMaXUgd3JvdGU6DQo+ID4+Pj4+
DQo+ID4+Pj4+PiBub3QgcmVhbGx5LiBCZWxvdyB0aGUgdXNlcnMgb2YgdGhlIHN0cnVjdCBpb21t
dV91c2VyX2RhdGEgaW4gbXkNCj4gY3VycmVudA0KPiA+Pj4+Pj4gaW9tbXVmZF9uZXN0aW5nIGJy
YW5jaC4gT25seSB0aGUgZG9tYWluX2FsbG9jX3VzZXIgb3AgaGFzIHR5cGUgYXMNCj4gdGhlcmUN
Cj4gPj4+Pj4+IGNhbiBiZSBtdWx0aXBsZSB2ZW5kb3Igc3BlY2lmaWMgYWxsb2MgZGF0YSB0eXBl
cy4gQmFzaWNhbGx5LCBJJ20gb2sgdG8NCj4gPj4+Pj4+IG1ha2UgdGhlIGNoYW5nZSB5b3Ugc3Vn
Z2VzdGVkLCBqdXN0IG5vdCBzdXJlIGlmIGl0IGlzIGdvb2QgdG8gYWRkIHR5cGUNCj4gPj4+Pj4+
IGFzIGl0IGlzIG9ubHkgbmVlZGVkIGJ5IG9uZSBwYXRoLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIGRv
bid0IHRoaW5rIHdlIHNob3VsZCBldmVyIGhhdmUgYW4gb3BhcXVlIGRhdGEgYmxvYiB3aXRob3V0
IGEgdHlwZQ0KPiA+Pj4+PiB0YWcuLg0KPiA+Pj4+DQo+ID4+Pj4gSSBjYW4gYWRkIHRob3NlICJt
aXNzaW5nIiBkYXRhIHR5cGVzLCBhbmQgdGhlbiBhIGRyaXZlciB3aWxsIGJlDQo+ID4+Pj4gcmVz
cG9uc2libGUgZm9yIHNhbml0aXppbmcgdGhlIHR5cGUgYWxvbmcgd2l0aCB0aGUgZGF0YV9sZW4u
DQo+ID4+Pj4NCj4gPj4+PiBJIG5vdGljZSB0aGF0IHRoZSBlbnVtIGlvbW11X2h3cHRfZGF0YV90
eXBlIGluIHRoZSBwb3N0ZWQgcGF0Y2gNCj4gPj4+PiBpcyBjb25maW5lZCB0byB0aGUgYWxsb2Nf
dXNlciB1QVBJLiBQZXJoYXBzIHdlIHNob3VsZCBzaGFyZSBpdA0KPiA+Pj4+IHdpdGggaW52YWxp
ZGF0ZSB0b286DQo+ID4+Pg0KPiA+Pj4gaW52YWxpZGF0aW9uIHBhdGggZG9lcyBub3QgbmVlZCBh
IHR5cGUgZmllbGQgdG9kYXkgYXMgdGhlIGRhdGENCj4gPj4+IHR5cGUgaXMgdmVuZG9yIHNwZWNp
ZmljLCB2ZW5kb3IgZHJpdmVyIHNob3VsZCBrbm93IHRoZSBkYXRhIHR5cGUNCj4gPj4+IHdoZW4g
Y2FsbHMgaW4uDQo+ID4+DQo+ID4+IEknbSBub3Qga2VlbiBvbiB0aGF0LCB3aGF0IGlmIGEgZHJp
dmVyIG5lZWRzIGFub3RoZXIgdHlwZSBpbiB0aGUNCj4gPj4gZnV0dXJlPyAgWW91J2Qgd2FudCB0
byBtYWtlIHRoZSBpbnZhbGlkYXRpb24gZGF0YSBmb3JtYXQgcGFydCBvZiB0aGUNCj4gPj4gZG9t
YWluIGFsbG9jYXRpb24/DQo+ID4NCj4gPiBUaGUgaW52YWxpZGF0aW9uIGRhdGEgaGFzIGh3cHRf
aWQgc28gaXQncyB0aWVkIHRvIGEgaHdwdCBhbmQgaXRzDQo+ID4gaHdwdC0+ZG9tYWluLiBXb3Vs
ZCBpdCBiZSByZWFzb25hYmxlIHRvIGhhdmUgYSBkaWZmZXJlbnQgdHlwZSBvZg0KPiA+IGludmFs
aWRhdGlvbiBkYXRhIGZvciB0aGUgc2FtZSB0eXBlIG9mIGh3cHQ/DQo+IA0KPiB0aGlzIHNlZW1z
IGxpa2Ugd2hhdCBKYXNvbiBhc2tzLiBBIHR5cGUgb2YgaHdwdCBjYW4gaGF2ZSB0d28ga2luZHMN
Cj4gb2YgaW52YWxpZGF0aW9uIGRhdGEgdHlwZXMuIElzIGl0IHJlYWxseSBwb3NzaWJsZT8NCj4g
DQoNCmUuZy4gdmhvc3QtaW9tbXUgbWF5IHdhbnQgaXRzIG93biB2ZW5kb3ItYWdub3N0aWMgZm9y
bWF0IGZyb20NCnByZXZpb3VzIGRpc2N1c3Npb24uLi4NCg==
