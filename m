Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84375B8FE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Sep 2022 23:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiINVJd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Sep 2022 17:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINVJc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Sep 2022 17:09:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501DFDC;
        Wed, 14 Sep 2022 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663189770; x=1694725770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OQApF4le2Can+AlpMgxpaRFigBqnWmtjDptEJ7ALJY0=;
  b=kA0ScRd5su9CJXifpjLKhoiV4RMMIx/iQLpvKlvHiEEF1flxR7ptkN5d
   qd+Kr16JRL5tHkumCddhOaG197RQjETtQgmFWIrA5WzYXIJPG8gEXegSw
   F+jJ1OU40+p2WsewoK5VX5VCjYUi7dQHgBr612OyJszCEFqJsYD+nLEWQ
   tG8mNi4PzdraxAUl+vqs5OceEu9EDncxhneZR2CsmH9Ea6DOHwSoaJu7e
   Ns/CV/YjH0Sq0s8XOu8CJhSIfr4oGK/fCGo5C0VFAFY1Se6kj/PYR5x4+
   4a54gwHQU2kjEuun9RXhp3v2nDAoYFcctSafmT+m5sX384XU6bp57IGFk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="360282924"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="360282924"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 14:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="612646793"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 14 Sep 2022 14:09:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 14:09:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 14 Sep 2022 14:09:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 14 Sep 2022 14:09:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 14 Sep 2022 14:09:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxWywBLy8TMlbscYZbTbPEAehz/qkAqsU3vEf/6VwWi7M2UK3rTMwZaM8OWua0y+rs1LB6w5aguL2aYBf0aa9b/XDXCuso5tkah0hNhYGwJfYrLmdOycb4fHWCwiJaiBznHa6ndgoieTG0a8RV0DUkwhsk+MAIeIS89u0rIKm82Fn8mgxotqBky/MIjcXDG9aaRBw5T0acW9cchwKHJoguh2eugu7WnTrfsjP6TfeK7HctlK+CYz8CwTgvJMkUYtiEDZ0ryC2TESl1fvZz9XiYg7QQCeMif3Mq8b18bB9KjIeHpfSqR1hB3ciCyru6Lf/DrXZ0S87ZpnUNKcyiFHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQApF4le2Can+AlpMgxpaRFigBqnWmtjDptEJ7ALJY0=;
 b=j8hO780viTMWfuRv2TDfv43raKaqffZkkvEqv+ajT9k9rYFbskwlfVG215RKjWH1B3mhqTYAE+nE3cVGKKWMXl/ODqamZObIPWXlEhq38V8fkVD69Attq035rq9dH/8ZHO9vQRt/il5tR3TumlhavoqexostMyj44cqdOVHEu0cy7MwKyY5m5KRBZ9FvTxpqoFO/j/YyICrppmVVTrprHah40H4VdTeA1x6ZSWn6prtGOo/TzoRNUAVEH2ZqHZ7cFDRtsDkJfdZzxa2t1m5RVfYsCecCgsuHZpXxQ5lZWXREjQ9tZYmlA3HfgNRP9LN0R+i5cGj4YmrB+Hi6ErGLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4579.namprd11.prod.outlook.com (2603:10b6:5:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.23; Wed, 14 Sep
 2022 21:09:26 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::e03d:fd3:dad2:2248%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 21:09:26 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Thread-Topic: [PATCH v13 3/3] Documentation/x86: Document TDX attestation
 process
Thread-Index: AQHYxII0umFKXJIJT0imMnKpHHEJMa3dqsYAgAB9bACAAUtSgA==
Date:   Wed, 14 Sep 2022 21:09:26 +0000
Message-ID: <6e74ba5e6dc40b4d3bb90b7a7f0d8a1b9655964c.camel@intel.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220909192708.1113126-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220913175440.wahcdmaumeqjgzmh@box>
         <c5868924-f2a0-d6fd-c757-ae539194f9f2@linux.intel.com>
In-Reply-To: <c5868924-f2a0-d6fd-c757-ae539194f9f2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4579:EE_
x-ms-office365-filtering-correlation-id: 17eb6013-74f1-47c0-0d10-08da96956806
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mot4DWtH2ZYEvjkScZkY0jonbYzKiWeeh/prIGUlT7D0XK6lWA6neHSETo8uuIPUKsBiAxFYNQ+SUnCpltpmiaO6D0SJhR7yXBSWMZ9RQrDKCeVJjF55k152dyNAS91uAEIW7bhQxmiR6a7bQsY+YFXqPRZOlkzoBicLoMFhSLHYF0CAj5aVZbBiKwGnnTp/hJXprOccLl4SD+C9HKGvGQygJDEjOz0/rWZeOMehkO1NypNiXNSOqGLpGQPCytMhie5Gr2MGR7NwqPbet8mxSs7v05ifo/vi3WQkoDiB/FqUhg3fx8wBbxYPR7Uk3+p78Y9QW6JIbYV1bj/rHHGTdVpJGZjZ0LSI/ofl9Nn+8OQV5/xQk8eDf9qn5fHoVpjvjzOSM4M29Rc6xmRrfePkxhTOT+4/AO1w3TcK8iSU6ddFZnzfVndp9B8BV+sCmJc9GdlepMvc+/zLh4+dZvHRh6xKLQ5YkMAg3hE5PttEvqynIbEmiHcuoj/C8Z3eRmexGgqj8FDc+VD7E4ZcIUe5bfYN3KYJ3FzAHI7RVuEjCZFvSY4cOeqBF9rFltxR4qJFhkY6P8IvwzYXNX+IkKKAdjygz4BeUIQoOoiPyfexBkxb5hPxysWxOQnFgnIVtI6h8r3aYki3M3RUr1xNftaRKyXyHlOZipnGFJ410z/QlwMFeqStKuTBebQDTf93DZNN8dsi4tpp6+1ua0kgmejtf0w/+tZj8cIakGgl97tRD3OCNJ7o2iMPgx6b3P3u/IWMUzcCJ75OlIjaUnnhSCAfeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(5660300002)(76116006)(91956017)(66476007)(82960400001)(41300700001)(66446008)(86362001)(64756008)(66556008)(6506007)(8676002)(36756003)(66946007)(186003)(2616005)(4326008)(83380400001)(7416002)(8936002)(2906002)(6512007)(26005)(38070700005)(6486002)(38100700002)(478600001)(71200400001)(122000001)(54906003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkhaOFp2VnpZMXU2dSttYkcyRHlWcndHbThETlpMVWdJQlg1VDFiUFYrYmJ1?=
 =?utf-8?B?di8zZ2owQlN0SU02Q3kycDIzL1VSWi9ob1VjNGZCRnU1Z2tITkdES3dXYkY4?=
 =?utf-8?B?eEIwZUlIMG5XQ1hiZmRrMURWNFY0cjdmOGhpdytiMWhhbUtTYlhJS1JXTGlU?=
 =?utf-8?B?YUpQdmx4eVdOWVJNN25PRlB2cEllUmdHRE4zQUsxdzRwMmxnSit6UWtZMzF6?=
 =?utf-8?B?dVZzNmJ4RDEyeDdmSmt3YUNiMFJVY3E5WG5rWXp4ZmZYMVpJS1d5bnBWQlhU?=
 =?utf-8?B?c2IyTFYvZHhzRjdoRlJ3b1J0Y1lUT3BFNmZOcjEwb25UbGVEVkRZN1prYnlQ?=
 =?utf-8?B?UjA5Sm9pMS91bVVqdkRNM25ETFJUaEtUZ2Ywb0VZTERjZzNhWWVhUHJKY0JX?=
 =?utf-8?B?MDJ5Z3FNVjNzYnhyaE1KQ3NzR2hadTNkeFZLWVZQSFRxcVdRVGpCbmUyRUhB?=
 =?utf-8?B?RE5wYzNocG9HOGxRQzVyb01nTU9uSitnUks1SUtqdFRHbStodzlnN3pWMjNJ?=
 =?utf-8?B?UkdRc1BlNUJPd1lhdXNXeS9QUVQwZm56bC9UaTladVQrU3EwVEEzQzM3REdU?=
 =?utf-8?B?eE4rMDVJZzdna1JVTGszelBiVjNmZkxncFVLMFUwK0pPdy9LZkJuT2NyaHMx?=
 =?utf-8?B?T3hVblRZaU1lM3BPWE9oT0hKT3NHTU00cVVPUSs0bE1CN3ptWUIyY2ZJN1dx?=
 =?utf-8?B?aXIxYmxFeGxxMS9uUHBOOEMyclMzZ2xQSzdEVWpueTVtdmZCaFRZTkFESjND?=
 =?utf-8?B?OWFWRzZ0ZTZGc3ovTXNTMG5GWm1HT3RiNkxLemtTdFNOQy9ibnNrcGRHVis4?=
 =?utf-8?B?eFlmYUpwZFMwSjlIb3k1ZkNkSTgyZERFUHlJbjAxWFpMb1FacmRvbGE1NzNX?=
 =?utf-8?B?eVhQRnhhVnB6OTVxWnVML1RFcFJRaEFLbmxBWGdoVGlaSWlqK3NjZ0tTOTFF?=
 =?utf-8?B?RzRGYVRuVmY4a1NNUzVmbUJzQ2dHL1QxSUwrZnR5OUVIZDJBZmlqT2V4TXVQ?=
 =?utf-8?B?TzIyZFdSOEdTb0ZGZ3g0Q0JNb1krby9kbnIrdVZXUmpZL2dJZEpXbWF3dDYz?=
 =?utf-8?B?WVdBR1VnWmt6U2pNOHpqRnI3eVdkSlg0dXFFUUlFTlhvMFM3eFBlY1BvMWp6?=
 =?utf-8?B?dTNSN2ljL3NVY0k0TzA1WTlsa2U1cWNsRTA5SytUN2FyYUQrZGllSWVHRzFD?=
 =?utf-8?B?US9qNjExcWdQZC9oYnltMk9kd0gzUjJDaVhjMkhlYjlJV1hKU0p2S1NVb1BD?=
 =?utf-8?B?S1ZiWWlLbGZQVFl3bzhWWHlaWVB1Tzl6YVNNZVA1VnhQNHcvVnIzbHhPeHM0?=
 =?utf-8?B?WjJ4bStvaWIrV0N3NytjZFl6b1kzL3dmRmJqRFA1UWpSR2FHaHBLekhaMnBu?=
 =?utf-8?B?WENxV3g2cXdDbFloN2NSYkRDOU5UWmlDVVZRZUNRSjdOeTFzK0xKS2gyVlNQ?=
 =?utf-8?B?ZHIrK2paRW9vM3FNZXkvU2ZURk9xUjY5TlRtYVRjSTlkSXppOEFLN3NuK1hN?=
 =?utf-8?B?RVhleVNpNWUvSjl6Q1p3MENoTzNsNGlrSFQ1WURRQzFqUmZKd2VISG5hcGI3?=
 =?utf-8?B?WVIvQkowcVBxVHhTNVN4UXRhWm5pcFhiWnpGK1YrZWhhWTRsVG40OGFFLzFL?=
 =?utf-8?B?TEJscEViVyt1bnZHdjRzY1FUNkZUS21iWm1DSW1nZkxWWHd4aFFuSjdmaldC?=
 =?utf-8?B?QVh3THh2cHkrc0JvdzBmQ3FjM3hHajhNbXNZdWtnSU1zL3ljdXo0T1dFeXRE?=
 =?utf-8?B?b1Q4dytRRnNRZ2kyeW9BZUhxaFlLRGdVVzllMkdYS2J4TXgzN2k4cnFzWDZC?=
 =?utf-8?B?Sm9qVms4S3BpUFI4MlBMeGNVT0ExT3FzWlBpbkEwR00zaHBFZy82TldUTEYx?=
 =?utf-8?B?K0luOHdXUTdpVTJIQnJwT25vYktETmE5NzgxcXhmRUFEVXh4bFRyTDVzdmZo?=
 =?utf-8?B?VERsZFZEZGZWYm5Jc1E1Y1NuODJpZTZvMnlwT25HL1lud1dpKy9CWlpxUGpQ?=
 =?utf-8?B?dTNkOVV0dndyZDJRbGZ1cU5kZE5OUUFqV1BjKzg0SjE4VVlzQk9JVWluK0kx?=
 =?utf-8?B?MUNsVG5UVUZPR2NlaytqSVRqb2xSczk2cHJueHVEMHA5Q241K1l1Z0ExVmxq?=
 =?utf-8?B?NlhmMDhNNUxFUVovdFMxZ0taeUtadmkySGJwNndnU3ZSSU0wSEw5SjNhNWxM?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <892548A99DE4FE478D4D58C6B3667098@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17eb6013-74f1-47c0-0d10-08da96956806
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 21:09:26.5710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u4e/NAFTB1rl7aZ41gH+FQZM8h6hb3X/rYOepFR0Nn9pO4uLRye11Y7/VSGJV6Z7t3FXG70uxjvzrQnOpRQIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

T24gVHVlLCAyMDIyLTA5LTEzIGF0IDE4OjIzIC0wNzAwLCBTYXRoeWFuYXJheWFuYW4gS3VwcHVz
d2FteSB3cm90ZToNCj4gQXR0ZXN0YXRpb24gaXMgdXNlZCB0byB2ZXJpZnkgdGhlIFREWCBndWVz
dCB0cnVzdHdvcnRoaW5lc3MgdG8gb3RoZXINCj4gDQo+IGVudGl0aWVzIGJlZm9yZSBwcm92aXNp
b25pbmcgc2VjcmV0cyB0byB0aGUgZ3Vlc3QuIEZvciBleGFtcGxlLCBhIGtleQ0KPiANCj4gc2Vy
dmVyIG1heSByZXF1ZXN0IGF0dGVzdGF0aW9uIHF1b3RlIGJlZm9yZSByZWxlYXNpbmcgdGhlIGVu
Y3J5cHRpb24NCj4gDQo+IGtleXMgdG8gbW91bnQgdGhlIGVuY3J5cHRlZCByb290ZnMgb3Igc2Vj
b25kYXJ5IGRyaXZlLg0KDQpJIHdvdWxkIHJlcGxhY2UgIm1heSByZXF1ZXN0IGF0dGVzdGF0aW9u
IHF1b3RlIiB0byAibWF5IHdhbnQgdG8gdXNlIGF0dGVzdGF0aW9uDQp0byB2ZXJpZnkgdGhlIGd1
ZXN0IGlzIHRoZSBkZXNpcmVkIG9uZSIuICBUaGUgInF1b3RlIiB3YXMgbmV2ZXIgbWVudGlvbmVk
IGJlZm9yZQ0KaGVyZSBzbyBpdCdzIC1FUEFSU0UuICBBbHNvIGdldHRpbmcgdGhlIHF1b3RlIGlz
IG5vdCB0aGUgcHVycG9zZSwgdGhlIHB1cnBvc2UgaXMNCnRvIGdldCBpdCB2ZXJpZmllZCBieSB2
ZXJpZmljYXRpb24gc2VydmljZS4NCg0KPiANCj4gDQo+IA0KPiBUaGUgVERYIG1vZHVsZSByZWNv
cmRzIHRoZSBzdGF0ZSBvZiB0aGUgVERYIGd1ZXN0IGluIHZhcmlvdXMgc3RhZ2VzIG9mDQo+IA0K
PiB0aGUgZ3Vlc3QgYm9vdCBwcm9jZXNzIHVzaW5nIGJ1aWxkIHRpbWUgbWVhc3VyZW1lbnQgcmVn
aXN0ZXIgKE1SVEQpIGFuZA0KPiANCj4gcnVudGltZSBtZWFzdXJlbWVudCByZWdpc3RlcnMgKFJU
TVIpLiBNZWFzdXJlbWVudHMgcmVsYXRlZCB0byBndWVzdA0KPiANCj4gaW5pdGlhbCBjb25maWd1
cmF0aW9uIGFuZCBmaXJtd2FyZSBpbWFnZSBhcmUgcmVjb3JkZWQgaW4gdGhlIE1SVEQNCj4gDQo+
IHJlZ2lzdGVyLiBNZWFzdXJlbWVudHMgcmVsYXRlZCB0byBpbml0aWFsIHN0YXRlLCBrZXJuZWwg
aW1hZ2UsIGZpcm13YXJlDQo+IA0KPiBpbWFnZSwgY29tbWFuZCBsaW5lIG9wdGlvbnMsIGluaXRy
ZCwgQUNQSSB0YWJsZXMsIGV0YyBhcmUgcmVjb3JkZWQgaW4NCj4gDQo+IFJUTVIgcmVnaXN0ZXJz
LiBGb3IgbW9yZSBkZXRhaWxzLCBwbGVhc2UgcmVmZXIgdG8gVERYIFZpcnR1YWwgRmlybXdhcmUN
Cj4gDQo+IGRlc2lnbiBzcGVjaWZpY2F0aW9uLCBzZWMgdGl0bGVkICJURCBNZWFzdXJlbWVudCIu
IEF0IFREWCBndWVzdCBydW50aW1lLA0KPiANCj4gdGhlIGF0dGVzdGF0aW9uIHByb2Nlc3MgaXMg
dXNlZCB0byBhdHRlc3QgdG8gdGhlc2UgbWVhc3VyZW1lbnRzLg0KDQpJIHdvdWxkIGxpa2UgdG8g
cG9pbnQgb3V0IHRoYXQgIlREVkYgaXMgaXMganVzdCBhbiBleGFtcGxlIi4gIFREVkYgY2FuIGJl
DQpyZXBsYWNlZCB3aXRoIG90aGVyIEJJT1MsIHRoZW9yZXRpY2FsbHkgKGVzcGVjaWFsbHkgaWYg
eW91IGNvbnNpZGVyIGNvbnRhaW5lcg0KY2FzZSBpbiB0aGUgZnV0dXJlKSwgc28gYWxsIHRoaW5n
cyBpbiBURFZGIGNhbiBvbmx5IGp1c3QgYmUgYW4gImV4YW1wbGUiLiAgSQ0KZG9uJ3QgbGlrZSB0
aGUgaWRlYSB0byBiaW5kIFREWCBhcmNoaXRlY3R1cmUgd2l0aCBURFZGLg0KDQpIb3cgYWJvdXQ6
DQoNCiJGb3IgbW9yZSBkZXRhaWxzIGFzIGFuIGV4YW1wbGUsIHBsZWFzZSByZWZlciB0byBURFgg
dmlydHVhbCBGaXJtd2FyZSAuLi4iLg0KDQpPdGhlcndpc2UgbG9va3MgZ29vZC4gIFlvdSBjYW4g
aGF2ZSBteSBBY2sgYW55d2F5Og0KDQpBY2tlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50
ZWwuY29tPg0KDQoNCg==
