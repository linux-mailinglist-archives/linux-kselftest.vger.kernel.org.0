Return-Path: <linux-kselftest+bounces-3585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2577E83C87E
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 17:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05181F219FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 16:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83713A252;
	Thu, 25 Jan 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cl2xNJIe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA817131E49;
	Thu, 25 Jan 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201021; cv=fail; b=KspCFKVUsclQWoyrbNeEm1tkMURkqP95PpYtAw99f8R75gYWP56Cau+o/1VKAph4M1HmXbI34AsiNDxZbSNosxpcKAyOyF84JBjdvcFY3R/crEYJpz00XQ1rHF/yiWzu2NrtPCVHWb0/pWwCk0cFc4o2EwA5b+Bqx3IsYeaga9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201021; c=relaxed/simple;
	bh=nQtjiTuyiOV10loO7PuWe1NHCRNllFIO4Jjxvuk0GTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mOQD5RjXt6nFoR/zU3dviM0s02iNFe6myATTgU5kK+WauUofbd///quVlSSEvzg+jOGExcHySoQUjYGTNUuT5G6YzOuAXkUEsf3iJwo8x5K7nRY8+TyTAh16Q2EzjD01e4VKpm5FRh0444I4iwJfRA/oEzbs8Qbm/pmAgo/qSO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cl2xNJIe; arc=fail smtp.client-ip=40.107.212.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8w2nTKPRjH643L93t+GhFUoqTBHYPFtmfZivyf25gh9Vn6IqX4y/GkaS77dkGY889E0+zezF9Au8XCv5Ges8KFXGAruYV1uqPdmgPHLBf37FLihsAx68JUQeLwTJO1CxXF4HHM8C7caqaGnv0T905ezEIljEo90J4p0WHZ5kq2UnuvwkntPQwPG+V2G0J0Gx2q9HkAXGoTtc/VI+Ewfd0ubvf3TbFZVLm04Zqb8o6yjPw5RG0z5zpdbDAwR8Kum0XnPtP7N2ami2trso62NHgSwB2NkUXemBQwzx7Rs2xdYJpNjKweznpMgDR/IkqucOyg0CGE/CG8dLbp5AKX5jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMhKQXdNIKc6ELU2dI+G9oqP+EZF3suFq5MINg6p/ic=;
 b=PU3POzdWIW5BXR29HGw3H6fQXKEm89ozoMdmWSd7869GHNgBBxEPAsGMMjmisdQux9jyekpLvF8xVyUyHoNJD4GCRgnG5fCu81CREoQNKMOlohxyxu7qwbokpyANzMWPpNAkq4LhJ/STtZSggv3O+Pteq+ZlabIWa6Y3BmA/HXw9wEOFvj3YtWdtT9/KGPFRNgNNumjEublQtVIxzkfY5sM7DHMfjb4nOXJNaTWE+VE5vvqyXNTZ43+tSfETkUCjj5sMLakqJC1s+eom2N1qgoMlsH2PRkKcfU/M7pHfiskchYVA8fyJ1rLeCo25qjq+D1rKiec6Qgn8dOWokY8Tpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMhKQXdNIKc6ELU2dI+G9oqP+EZF3suFq5MINg6p/ic=;
 b=Cl2xNJIeX+MAZkT9DtZK8HvKXJgMwcEn5GWBOT3x9zrds9o9+z4lg1JztOes3/5fq2N9sZqTZsB+GFEHy64EcBnpiY9U7ESXWo67HzbqN712sCKInrtZz+AEl2QtWJKigVdA7RMQwXWGWKdZ4WDbyN7J+1ZIe5LZsKXdWblot1vqV+qaghg0NDc8EFotuGpdlC8qHTUHc1vzWyfKeTESfDZnX4IEJUBaGRMk3ZfoNc3OWywU2hWufuVbzoB7PzTfz03FaUHWx6mrjXoFw0E6jz31ksfkXwA7QHiPVe5GNdjL/99IUezzvH5kITJvmIdW30gG+tmU2KieQO95n0+pqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 16:43:36 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 16:43:36 +0000
Date: Thu, 25 Jan 2024 11:43:34 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Davide Caratti <dcaratti@redhat.com>,
	Tobias Waldekranz <tobias@waldekranz.com>,
	Zahari Doychev <zdoychev@maxlinear.com>,
	Hangbin Liu <liuhangbin@gmail.com>, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] selftests: Introduce Makefile variable to
 list shared bash scripts
Message-ID: <ZbKPtgJus0EbFkG_@d3>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
 <20240124170222.261664-2-bpoirier@nvidia.com>
 <20240124204612.4c688095@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124204612.4c688095@kernel.org>
X-ClientProxiedBy: YQBPR01CA0076.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::12) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3679b8df-4f4b-4645-f3e6-08dc1dc4c663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7KaqkMYZv0McGHrDvrdXSfyXyiCUZLnhO4wK/Wdi0grzEjiPAXqEhz0CGb6ueQNXV5aUhjkk7mo25KA6HGP2mqGmFyjIazDjYLMnVWz/9Ps264qNcZADka1ZeBD9pSMe/a6INtfmWgM0NqZ0DQT2V+G4F1KIEYXpx+iNj5CtOJTQr2lCZF+AWrWvw99RZAvQEeJUAYCxQU6IbpeGfl7+gT/rJmf/XarhOoAq5augRX5ONGD5mtwyBs784SCEhfAWfLcv7gdYw4N1OQ5LeRUM+/Az3bU6JTf0wup0sA9jrq5xzXJcgxBg/1+lCXEjJJnlUW6N8y5c0xaKBeuXfzI4G0hGD9aKQS4Dpm84t95UBO2R4BCB0jaOzL/dvjuzJkr+kGgWGK4qNNsaZlm6H0b4SbVnpl8bQ9tirVWHdWKqmIpwuSi4TBePymzpdv8w3fWDL69dNwJSzX/myEY5SeIu3qX8SQ1ZNA4Ffhj7+uuJvaIoz+5lhZuDMBIuagYE6HghxEiUeqAlCsDMYIBdaMopI7EPgfrUjn2u140UR+G1GFA6IGVXmvq8yRmDNH6LCeXPxtFu4/LXEB4PJzhKgrH0f/G+wJQoz+/OuWJXziqIcTuGRcAR7Ft01rLdcHeE5cuN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(7416002)(2906002)(5660300002)(4326008)(26005)(54906003)(66476007)(66946007)(6916009)(316002)(66556008)(478600001)(6506007)(53546011)(6486002)(8936002)(86362001)(8676002)(83380400001)(6512007)(9686003)(33716001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jla9bqeOG1pwkshN+FmOSEDa3aQ35SiDAbwWvBd3nDXBQfhYoutYgQVEAZoo?=
 =?us-ascii?Q?Xy1cg4ae94Qf7uufxer2gSJdH15l8/MabkarDdiJkNhoL9xihEDSsjGyA2aH?=
 =?us-ascii?Q?BnQ9ECRy6L+Jkfc3ibbUAs4Y8QuAc+HqwijSoYwr5xTZa78PaBr0E5u9WIxe?=
 =?us-ascii?Q?U7e98jhiQaxNq8pioN4QidX91RVOrCvzJpq0j+9UAjhivoE/NeI4AOBPnZYI?=
 =?us-ascii?Q?AplrBZ6nlDmWurBBt8JyvkyhHL8flVHKUbQag+f2c9xpriY72s3+62+a2KgX?=
 =?us-ascii?Q?LMu0TSvSup/neir9xxsiPrX2bdZonT0XRywlK0arJvIZlBPcPbXBbMs2gLPV?=
 =?us-ascii?Q?77zibb1lIVa3PVlc6x7iZ32F7xRQE9MwAtnwCZvgtwkDfnWsrNDwKDO8UwVM?=
 =?us-ascii?Q?PN20p9I56laG72pyo6e+cGgd1QabRJIqe9hiTUJDTgMXc7vfYYJGByDOF/sw?=
 =?us-ascii?Q?15GvFK8S+x8rV337+GcLETrMdNhMhdvFbafZAa+Glu7/O1MRdYkn4/s8ZjW+?=
 =?us-ascii?Q?kpQ+Mq8Vh7dEhHSeyyHSbJeold5bRnYUwDlX3ewPl4vPhYjGCy8PM6UJ3rm/?=
 =?us-ascii?Q?0Mybv3FmLjTwkBvC4xoy6fYR55GYDx00/sijuBReSlAXp0jKJZfL9gXi2OAZ?=
 =?us-ascii?Q?IS4UunA1TpI2oRIPtGUn7Zz6iamQtKhH8P7OYiMT/SAb3gjN1gsGLhcY80IK?=
 =?us-ascii?Q?7MxfXhAwMFzj3A3Pum4uag+oH8wKnVnAfOG696NZMpJrIgVMX0inT/XJ4M/t?=
 =?us-ascii?Q?j4FflnaM8291cuEyZPGGhvsvV1F1wqdioLbcLbQ+y+nf436ssalZ/tT5W58X?=
 =?us-ascii?Q?WbvQyDoRinU8el4SYesW2jFT4Bu9AYeh4Ukckg/ppzh/RJRfRuy5sDapeJHd?=
 =?us-ascii?Q?FztuP3EaTWqdE72r/o90aEgAhngb1oLufRMxNdF5VDY4xobTKLjwldtpNs2m?=
 =?us-ascii?Q?1U5MglstAzAnk7ztOdoLZEtMiwp5Wc6Re3hy/Zo1eAV6+evaBZ25HNQfLV3K?=
 =?us-ascii?Q?6Mwda/2pTypyJ3VjyAwnMAkaFC5YJmrirZibbJPqlIJLh56ZHgHmouoot6Kj?=
 =?us-ascii?Q?125FC+qF1odtv7FaexygjIX6WO6wCgr+F5Ao12wgtB4hiYLDcDri5+uFtBL1?=
 =?us-ascii?Q?1jr3d5CnwK+8/PE3snig3cFw9M92lP/WJLYHucONozTQqZZnu7EF06iM8Stf?=
 =?us-ascii?Q?q52Hdi68i5jeTVdtzjmucj3SdfT9DQ+nNiS/lj+ePEraLkQIRdS4eUekW6ez?=
 =?us-ascii?Q?hwQOI+pFLXor05uWWzEBXBg67dmFOVRNmU675+kpOg/ZHUlpKfHd3Uplf4A2?=
 =?us-ascii?Q?BbJ0HNNan7uDm/3+zKO35wttWjGfaOf/i5DHY3fC4oSDM4IOUwaX6OOuNPc1?=
 =?us-ascii?Q?IaY0k7mhOZzPh4LHYmYl9+GgezaTO6glrMZ4VVtu3rQLX+i9JC4L3mNCIcTi?=
 =?us-ascii?Q?Oto4FiX0wQSn8T89HtANYdOa1NJUMoUeuw6vDIZ7l78iYLGISJsXDuVoZ5rB?=
 =?us-ascii?Q?ACxTOfrBf3buvB9iuNqhJSy82RS7zdSwHpzvWYMAq9YWjy49y1CaAM2ORGZk?=
 =?us-ascii?Q?eNGi9qbHD583rd1XCJMKdH2f0WcIJb+FZvfp8ZGu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3679b8df-4f4b-4645-f3e6-08dc1dc4c663
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 16:43:36.1675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akHrZUMtVaJZA9CvEJab+EKdAw/I8FzpCftdJISe17et2MuBqcxUweH0RKM3LwCSyuArIpTSC+vPmFjn0gMPOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284

On 2024-01-24 20:46 -0800, Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 12:02:17 -0500 Benjamin Poirier wrote:
> > --- a/Documentation/dev-tools/kselftest.rst
> > +++ b/Documentation/dev-tools/kselftest.rst
> > @@ -255,9 +255,19 @@ Contributing new tests (details)
> >  
> >     TEST_PROGS_EXTENDED, TEST_GEN_PROGS_EXTENDED mean it is the
> >     executable which is not tested by default.
> > +
> >     TEST_FILES, TEST_GEN_FILES mean it is the file which is used by
> >     test.
> >  
> > +   TEST_INCLUDES is similar to TEST_FILES, it lists files which should be
> > +   included when exporting or installing the tests, with the following
> > +   differences:
> > +   * symlinks to files in other directories are preserved
> > +   * the part of paths below tools/testing/selftests/ is preserved when copying
> > +     the files to the output directory
> > +   TEST_INCLUDES is meant to list dependencies located in other directories of
> > +   the selftests hierarchy.
> > +
> 
> I think that this chunk causes a warning when doing make htmldocs:
> 
> Documentation/dev-tools/kselftest.rst:267: WARNING: Unexpected indentation.
> Documentation/dev-tools/kselftest.rst:268: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Could you double-check?

You're right, thanks for pointing it out. I'll send a v2.

