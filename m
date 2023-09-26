Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3AE7AE619
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 08:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbjIZGiW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 02:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbjIZGiV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 02:38:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6371AF;
        Mon, 25 Sep 2023 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695710294; x=1727246294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2n4lftCXNvUerJzO/KNdwgYdUe39ZTwXwja1PnglJgU=;
  b=Ykr4EqHenPn8N2KVlJcFd6F6G2m+DDWrx9RQOKiJrqSqPaj4bbTQA1qZ
   l7z88ph0VGMsZE8X7hHgtbBD8CMRmLSd7MKTeCb2maFhq3ru1mweihDHn
   AV4cHfJ6atqeKjkNW7bltDXEohWuZjcB4rw7rqJ/yTgUeTCN5+zYrhDW8
   CPhOP+X70mKkWtuOT/8qw/trTTtLZTSbMLfn9KTrTSQS0jkHurYyI2nAL
   eIaRG3/dWR1G2G5Zml7dloEgenVxshf4hhe/Hrf46BhZ+Jvsiss9wVINw
   gvLqfMuqU/2AX0gloCLToH67TefFskQI0+LM700taKnma5jSJp/e4aFBL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="385347302"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="385347302"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="752044779"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="752044779"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 23:38:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:38:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 23:38:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 23:38:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 23:38:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyWxnAi1xHshnZMcdTGANuoTfrvWfsnCct4D3yeiK5Qt1R/hmoMjTCjtkFoJeZFM0U0H/+QVlOo/Am2eSgjJYZUwgn0abOKdpmxGPsSd2tKDDo4on7S+alw9opSLeUP/9JycZaBUE4a+zW4IJM5yTL6CRm3naaMgwPLjCjRnwe0kT2P6rYYJFwg34EfsEDQAdFFfZLrDk8sq+bwtXlbF4ZEk6uMGIZ9dZJPm6qvn4rJg54Ws5GM6iSD7gK5C/uW0q2tkzFtk0aQYWiyc9rTNzbZy8shVRaI25qWj4VvaNxn8tqOwn14nI0yA/opSjwHuSpBTwLJFmdXteZFnyd0nvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2n4lftCXNvUerJzO/KNdwgYdUe39ZTwXwja1PnglJgU=;
 b=ZiEYnq1sHEm28Hd02rWdjwiuCPi9LUorDCFLfwiZFlUCplV6OxvwOIiXMLnmQrwSdMZDVPuwXO1ZT3zN7m9X800otPm8XDrkwDMdAxkA6tL/M8YWXqLqX9rnF2r90wbZHZOnxHKVUhQHL5yWApEjnDDDs4pDAEpzQy1wmJ1aVHyx3qmAAwrC8Xfk1JIcWgNQgUHjLzpQbHiWzAb5touOnUxvO/qLmRe/U74kNaikm2NGyIHR+7hv98VLWHW8iVrCKlRxUhzQooNx6ULXEGgWGSEcluGfrmq9BZ7DKILP2xnjKQvdpQQpsUxaLKdJaMCkxiTRAbYXyiRCD386m2/yDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Tue, 26 Sep
 2023 06:37:56 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1bfc:7af0:dc68:839d%4]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 06:37:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Baolu Lu <baolu.lu@linux.intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
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
Thread-Index: AQHZ7GCQqMA2D6hFIkG8of68DC8uNLAlMOeAgABMNICAAR3BAIAGE8WQ
Date:   Tue, 26 Sep 2023 06:37:55 +0000
Message-ID: <BN9PR11MB52765B3F127EE04E4A79C7778CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <0d37a1b1-e7ef-fa73-d17c-629cd254ae75@linux.intel.com>
 <20230921164447.GQ13733@nvidia.com>
 <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
In-Reply-To: <dcde6757-8d14-6460-c75e-c30d69219e4b@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7048:EE_
x-ms-office365-filtering-correlation-id: c77aba34-a22d-407c-ab56-08dbbe5b1df2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1W7t73XyvuEobNAZKd8x5gBr8qVZKxN40DEM/r29+Aiv35QH1y5LV+mBU6NKWmMpumTdaP7lUpePIT/p1T4N9VoS8G6k5aXjUB9NIR1fSaRVXIpa1rtS+vXQe2oR3YfebQ9csQ/QE+KCJV0+mtK5ZzV3stCDaIVzEu+mo/OV82VWRDkbRC3p88eZv+xzDSiqBA7T6SQRcOj32XmaGZgz5D9z1wqg2YMa20CjniL838mpu6W20g8UJQMYPUCeZJBoRHklPzGxoP3jfsnn8VSCi3oL1GwVoypLm+6TS21ZtKc1OsvskobwzB5Jpino36C6HlNCGTBF3bgdAN28LSse3bTq3Cl1OQH+Ie1FcV9oIvVDhL2/yWeu2bIzQj4Bur7zpQ6ySmvRji5a9FnH6lPPFQoDNnWrqMf+B+9IXTu78Gwu8IylDX5iKKzVO5UiI2LRgpOxf9U4AG21W1tOYTDJY10GPXTSA1GN1dlJtfSBk64j1+uH1tLc4Lkk6ee0l05Tk3YppxKV8ed1CYvOufUay2+JMIo2PX5xojNAs+jZFilsN0w9pMs/Jz3AkvpJWiC97z8Gv6EN8g2tHiPBaukEzTo3WWADWGUcP+MHpveYGQYaVn2a7jCyTnrsgWwynTN5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(2906002)(9686003)(71200400001)(7696005)(6506007)(38070700005)(38100700002)(66556008)(66476007)(33656002)(66446008)(64756008)(54906003)(76116006)(110136005)(86362001)(66946007)(478600001)(83380400001)(122000001)(26005)(82960400001)(4744005)(5660300002)(55016003)(7416002)(52536014)(41300700001)(316002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU1xNzQrb1g3bVNyYjZWUHQxWmlQSEZUVk5PNmZxeGdpVE9iU250eGVrSFd4?=
 =?utf-8?B?UGl3c1AvN204aTFSbnB1b05wMTNRM1Vna3RHQXMwSnlVMXhFK3k5Yi9pRU9J?=
 =?utf-8?B?N1U3bTdmR3pLYmh2Rit6aTRldXdBUFRnZkxhS3hhQ2VJamdLNmxwS2NTZGRM?=
 =?utf-8?B?MXBSMDNFZDBjQlloOEdOTE5sTG1xaHdvRVJvSVBKWkZPTUFYM0d0QUJCTThs?=
 =?utf-8?B?WEVOeHhuakErY1JRdTR3Sm5TR3BUTytlUVpsK3ZETnNRcVRaVXMvQlNvQUpZ?=
 =?utf-8?B?OGJvbUxCakNiakI1MDJqb2VzU0tuRlVJbXFyeGI1U3phYnJxbUVsSWc0RDdW?=
 =?utf-8?B?bklyWG5MUnJtNHlEYjlRQmQrVjhJNS9UR0p4TVpROE43U2daUFM5MXFDWVFK?=
 =?utf-8?B?dDVVcW54WDMrekpLM1I1QlhOSGF3UmFPM2h1TEpXeWpFKzlBWDZuYXVvQmV5?=
 =?utf-8?B?M1VNbVJ0dGFXSktHNys2Z0UweGJtOXI0QTYySitqbmd0bUNjVElRYTNDTkN6?=
 =?utf-8?B?T1E1cGZGZ0hybTlZQ09Fb080RWRoWHJ6bWNOdHRyMnJlZlU0YllremQ0ek9K?=
 =?utf-8?B?Yy83ZEFZelRqelF0djN1VDZadlJvYTJiRHRmTW95cHYvMUs5WmRqME9MTFpj?=
 =?utf-8?B?cCswTU16R2VtSDRwNG9mREpqYzB0YUl0VFlvWllXY2ExdlZVSmJVZUtzN0M4?=
 =?utf-8?B?NUx6REpua3lkZi9BZ3QvRlhzSEFDREQ5ZHA3cEhHZFhqbUtkOHhqM2RYS3Vs?=
 =?utf-8?B?Y2xicjd2b1JJNjRDVmlFdW5CY1hwQkgzaDNpcXZOblV1ODc1OW03N0FMQW5u?=
 =?utf-8?B?SldmVW9KL0tYNVJzdDZmckJ0Z2xRMkVOenRVcTJTQVlCZEZaV21keGZXWjFZ?=
 =?utf-8?B?QWZ2dmJnaHFlSzYwVmNzblhURE1mUGZTWWJlWnpHbWRraHlYSE94S3E1b3hy?=
 =?utf-8?B?QU9zSDUxb1VDS0t2ZnYyZ2NBc29JUjhNOFg5bnpLUSs5c0JBRVM5ZjdtcnZh?=
 =?utf-8?B?UnN5ZXV5c0pOditNaHFFdkg3bFU1WG1zK2x2NjRYalBlbHYxNWRxK3FGUGcr?=
 =?utf-8?B?eC9EMGZ1OWt2TGt2VUlJMU5xMno5bWlDdk9RRkM0TkhQOVNEOXMwS3FpcFFW?=
 =?utf-8?B?Rzg2S21rejRQTmdvRFRGNFVXdXl0RE1sVXJUcDNWQXZIcFN0RGJ3cGJWNXJZ?=
 =?utf-8?B?eklOK0VZcitqWnlHUDNlYzFla3lSSk9leG1FYXRMQklPOUV3ZlptZkxjVFlw?=
 =?utf-8?B?R3g4MWZndEdaRy9zOThkcGNub2hzamIrYlZjOXVrY1V2TVB4VE1tdWk4ajZP?=
 =?utf-8?B?UW9ER0FHRFF6c2dlU0hKdkp2WTlaV3JNVkxwUXY3citrb2ZMNGorZVZuNkVW?=
 =?utf-8?B?M0txNld2UTdTME1LOXQ2aVdGYjNoNHY3MGlSUlJuMjh1Sm10R2R6Tm9kK1F5?=
 =?utf-8?B?TWJ3a3FnRlZDMzhyVW5FTkNyVmRWNWd0Z2tOUWZjbXhoWURuM1FIb0tEK0hH?=
 =?utf-8?B?WGpHU3EwcFdmK3dZMTVtMTZpZmkwdFhZS0Y2bExsblBlOUlKL3J3aU9BTXhK?=
 =?utf-8?B?L1NnTG40VjUxZHJtOXl2WDRpNTVCVWtwbGZnYmQxcHNORmVIVjIvRHNQb0Za?=
 =?utf-8?B?RFoxQ0g0RG55YTVPbWo5Wk9WWm9wV3FjUXMrQjVDZkxySmhPc2g0RENtTXZK?=
 =?utf-8?B?dW0wOUR0MmhmR1RnMG4zY0pHcHhMQ05UQmRxeEZuNmlSaHpMenNrY1IvcTh1?=
 =?utf-8?B?M0IvSGJ5QXNmUkEvbzFIM0V2dDJXbno3U2pKL2l4c0VnNzMyVWZwTVFJWTlW?=
 =?utf-8?B?UWM0SmlKUXFWSmlqU0lBWHJtaGMvbWM0N25SRHNiSUdDRXpOdG9BY255algv?=
 =?utf-8?B?NWs5RVlFR1pWRXk0Y1o3MjMvN1gzKzRqM1Fod0ZqZ0pUMWZKempxZjdKdGcv?=
 =?utf-8?B?L2szUGhjbUFwa01uT1RMcFE3dk53RHRnNW1JeGJMdEdxVW5HOFJBdWk5NTZs?=
 =?utf-8?B?QytJNkVyYVB5ZDFJR3BtaHo5a3BmeDlFNUVsZFVFZWJVclBBdjgyY0VtOG9s?=
 =?utf-8?B?YTR0SlI3YVl4a3pES0NVL2o4Y1hvV2pvSkpxcUVZRCt6TFg4ZzRhTlk4UFNX?=
 =?utf-8?Q?CUDWNWBGR+v+PZQj/Sd+jSZD2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c77aba34-a22d-407c-ab56-08dbbe5b1df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:37:55.6281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JGxDmCK8ZYfAmLW7/8jhFU/UK1MBu7JwJsqZFpyO9h4Ns/1MwX2H9X4NegeLMW1yBJaAUw8Ji1WYGAPUoY4I0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBGcmlk
YXksIFNlcHRlbWJlciAyMiwgMjAyMyA1OjQ4IFBNDQo+IA0KPiBJIGNvdWxkIGdvIG9uIGVuam95
aW5nIG15c2VsZiwgYnV0IGJhc2ljYWxseSB5ZWFoLCAiZGVmYXVsdCIgY2FuJ3QgYmUgYQ0KPiB0
eXBlIGluIGl0c2VsZiAoYXQgYmVzdCBpdCB3b3VsZCBiZSBhIG1ldGEtdHlwZSB3aGljaCBjb3Vs
ZCBiZQ0KPiByZXF1ZXN0ZWQsIHN1Y2ggdGhhdCBpdCByZXNvbHZlcyB0byBzb21lIHJlYWwgdHlw
ZSB0byBhY3R1YWxseQ0KPiBhbGxvY2F0ZSksIHNvIGEgZ29vZCBuYW1lIHNob3VsZCByZWZsZWN0
IHdoYXQgdGhlIHR5cGUgZnVuY3Rpb25hbGx5DQo+ICptZWFucyogdG8gdGhlIHVzZXIuIElJVUMg
dGhlIGltcG9ydGFudCBkaXN0aW5jdGlvbiBpcyB0aGF0IGl0J3MgYW4NCj4gYWJzdHJhY3Qga2Vy
bmVsLW93bmVkIHBhZ2V0YWJsZSBmb3IgdGhlIHVzZXIgdG8gaW5kaXJlY3RseSBjb250cm9sIHZp
YQ0KPiB0aGUgQVBJLCByYXRoZXIgdGhhbiBvbmUgaXQgb3ducyBhbmQgd3JpdGVzIGRpcmVjdGx5
IChhbmQgdGh1cyBoYXMgdG8gYmUNCj4gaW4gYSBzcGVjaWZpYyBhZ3JlZWQgZm9ybWF0KS4NCj4g
DQoNCklPTU1VX0hXUFRfVFlQRV9LRVJORUwgdGhlbj8NCg0KSU9NTVVfSFdQVF9UWVBFX0dFTkVS
SUMgYWxzbyBkb2Vzbid0IHNvdW5kIGEgc3RyYWlnaHQgd29yZC4NCg==
