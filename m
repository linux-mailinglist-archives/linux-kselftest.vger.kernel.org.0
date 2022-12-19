Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52906514CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Dec 2022 22:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiLSVZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Dec 2022 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiLSVZA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Dec 2022 16:25:00 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589EB13F09;
        Mon, 19 Dec 2022 13:24:56 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJLE3Tg031484;
        Mon, 19 Dec 2022 21:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QP9Uka1TmzuRxHJX00LBjpwrqeQxRd737K2aT1PXO1g=;
 b=SnhjLYwJsaGt26EPpcfMeIIUGfJU+pmCWsax5JZgG0yLR8boAcFeZdUzPw/WXUUP7KLO
 H5C52t13e+XsEytxjQiUxvZr37q0517Xm01RvOX2gc3gODbJGKAPkK44Zl1U/h84xj99
 T8fJ4G0UvqW9bXQ75fXK0Lu6Si1P1vyvjoP8NcGV+lw2dw72eB9B6frpSUx6zk88MJYF
 jUE9O0YRpiYbGVQYRaNlsmuWzc08KcWfwsTJ6AKkTxIJRzZfYlUjkxpy6GBGylkHTWou
 jN8MLRVljGjxU6Nbbjkc2Pn6q846wPNPHuzyvWhCq97geO46ABfFbu8LxjCn+6RZR9TS Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjypk89dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 21:24:42 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BJLE8ui032046;
        Mon, 19 Dec 2022 21:24:42 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjypk89cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 21:24:42 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJB9X9G026099;
        Mon, 19 Dec 2022 21:24:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mh6yxj8na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 21:24:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJLOYWZ47579526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 21:24:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8553C20043;
        Mon, 19 Dec 2022 21:24:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1091420040;
        Mon, 19 Dec 2022 21:24:34 +0000 (GMT)
Received: from li-7e0de7cc-2d9d-11b2-a85c-de26c016e5ad.ibm.com (unknown [9.171.132.54])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 21:24:33 +0000 (GMT)
Message-ID: <4b96b112d5415d08a81d30657feec2c8c3000f7c.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sven Schnelle <svens@linux.ibm.com>
Date:   Mon, 19 Dec 2022 22:24:33 +0100
In-Reply-To: <202212141025.6iR1ex8g-lkp@intel.com>
References: <20221213165405.2953539-2-scgl@linux.ibm.com>
         <202212141025.6iR1ex8g-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r-29NuhBeO7LkKh-TX35kle0CICPUgiy
X-Proofpoint-ORIG-GUID: eXjQ--XeMjxovhxa2oYPtE_r9i17ZbA8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212190186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2022-12-14 at 10:23 +0800, kernel test robot wrote:
> Hi Janis,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on 739ad2e4e15b585a0eaf98b7bdee62b2dd9588c9]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Janis-Schoetterl-G=
lausch/KVM-s390-Extend-MEM_OP-ioctl-by-storage-key-checked-cmpxchg/20221214=
-005540
> base:   739ad2e4e15b585a0eaf98b7bdee62b2dd9588c9
> patch link:    https://lore.kernel.org/r/20221213165405.2953539-2-scgl%40=
linux.ibm.com
> patch subject: [PATCH v4 1/9] KVM: s390: Extend MEM_OP ioctl by storage k=
ey checked cmpxchg
> config: s390-randconfig-r004-20221213
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/4e0991bd47ba30c75=
88e042da7a84d84b9f84056
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Janis-Schoetterl-Glausch/KVM-s39=
0-Extend-MEM_OP-ioctl-by-storage-key-checked-cmpxchg/20221214-005540
>         git checkout 4e0991bd47ba30c7588e042da7a84d84b9f84056
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cro=
ss W=3D1 O=3Dbuild_dir ARCH=3Ds390 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    s390-linux-ld: arch/s390/kvm/gaccess.o: in function `__cmpxchg_user_ke=
y':
> > > arch/s390/include/asm/uaccess.h:410: undefined reference to `__ashlti=
3'
> > > s390-linux-ld: arch/s390/include/asm/uaccess.h:411: undefined referen=
ce to `__ashlti3'
>    s390-linux-ld: arch/s390/include/asm/uaccess.h:458: undefined referenc=
e to `__ashlti3'
>    s390-linux-ld: arch/s390/include/asm/uaccess.h:459: undefined referenc=
e to `__ashlti3'
>=20
>=20
> vim +410 arch/s390/include/asm/uaccess.h
>=20
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  396=20=20
> 4148575abe1e14 Heiko Carstens           2022-11-02  397  static __always_=
inline int __cmpxchg_user_key(unsigned long address, void *uval,
> 4148575abe1e14 Heiko Carstens           2022-11-02  398  					      __uin=
t128_t old, __uint128_t new,
> 4148575abe1e14 Heiko Carstens           2022-11-02  399  					      unsig=
ned long key, int size)
> 4148575abe1e14 Heiko Carstens           2022-11-02  400  {
> 4148575abe1e14 Heiko Carstens           2022-11-02  401  	int rc =3D 0;
> 4148575abe1e14 Heiko Carstens           2022-11-02  402=20=20
> 4148575abe1e14 Heiko Carstens           2022-11-02  403  	switch (size) {
> 4148575abe1e14 Heiko Carstens           2022-11-02  404  	case 1: {
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  405  		unsigned int p=
rev, shift, mask, _old, _new;
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  406  		unsigned long =
count;
> 4148575abe1e14 Heiko Carstens           2022-11-02  407=20=20
> 4148575abe1e14 Heiko Carstens           2022-11-02  408  		shift =3D (3 ^=
 (address & 3)) << 3;
> 4148575abe1e14 Heiko Carstens           2022-11-02  409  		address ^=3D a=
ddress & 3;
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16 @410  		_old =3D (old =
& 0xff) << shift;
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16 @411  		_new =3D (new =
& 0xff) << shift;

Not sure what it is in this config that causes gcc to emit this symbol inst=
ead of a shift instruction, but casting old/new to 32 bit fixes
the error.

> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  412  		mask =3D ~(0xf=
f << shift);
> 4148575abe1e14 Heiko Carstens           2022-11-02  413  		asm volatile(
> 4148575abe1e14 Heiko Carstens           2022-11-02  414  			"	spka	0(%[ke=
y])\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  415  			"	sacf	256\n"
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  416  			"	llill	%[cou=
nt],%[max_loops]\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  417  			"0:	l	%[prev]=
,%[address]\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  418  			"1:	nr	%[prev=
],%[mask]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  419  			"	xilf	%[mask=
],0xffffffff\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  420  			"	or	%[new],%=
[prev]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  421  			"	or	%[prev],=
%[tmp]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  422  			"2:	lr	%[tmp]=
,%[prev]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  423  			"3:	cs	%[prev=
],%[new],%[address]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  424  			"4:	jnl	5f\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  425  			"	xr	%[tmp],%=
[prev]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  426  			"	xr	%[new],%=
[tmp]\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  427  			"	nr	%[tmp],%=
[mask]\n"
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  428  			"	jnz	5f\n"
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  429  			"	brct	%[coun=
t],2b\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  430  			"5:	sacf	768\=
n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  431  			"	spka	%[defa=
ult_key]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  432  			EX_TABLE_UA_L=
OAD_REG(0b, 5b, %[rc], %[prev])
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  433  			EX_TABLE_UA_L=
OAD_REG(1b, 5b, %[rc], %[prev])
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  434  			EX_TABLE_UA_L=
OAD_REG(3b, 5b, %[rc], %[prev])
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  435  			EX_TABLE_UA_L=
OAD_REG(4b, 5b, %[rc], %[prev])
> 4148575abe1e14 Heiko Carstens           2022-11-02  436  			: [rc] "+&d" =
(rc),
> 4148575abe1e14 Heiko Carstens           2022-11-02  437  			  [prev] "=3D=
&d" (prev),
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  438  			  [address] "=
+Q" (*(int *)address),
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  439  			  [tmp] "+&d"=
 (_old),
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  440  			  [new] "+&d"=
 (_new),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  441  			  [mask] "+&d=
" (mask),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  442  			  [count] "=
=3Da" (count)
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  443  			: [key] "%[co=
unt]" (key << 4),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  444  			  [default_ke=
y] "J" (PAGE_DEFAULT_KEY),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  445  			  [max_loops]=
 "J" (CMPXCHG_USER_KEY_MAX_LOOPS)
> 4148575abe1e14 Heiko Carstens           2022-11-02  446  			: "memory", "=
cc");
> 4148575abe1e14 Heiko Carstens           2022-11-02  447  		*(unsigned cha=
r *)uval =3D prev >> shift;
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  448  		if (!count)
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  449  			rc =3D -EAGAI=
N;
> 4148575abe1e14 Heiko Carstens           2022-11-02  450  		return rc;
> 4148575abe1e14 Heiko Carstens           2022-11-02  451  	}
> 4148575abe1e14 Heiko Carstens           2022-11-02  452  	case 2: {
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  453  		unsigned int p=
rev, shift, mask, _old, _new;
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  454  		unsigned long =
count;
> 4148575abe1e14 Heiko Carstens           2022-11-02  455=20=20
> 4148575abe1e14 Heiko Carstens           2022-11-02  456  		shift =3D (2 ^=
 (address & 2)) << 3;
> 4148575abe1e14 Heiko Carstens           2022-11-02  457  		address ^=3D a=
ddress & 2;
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  458  		_old =3D (old =
& 0xffff) << shift;
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  459  		_new =3D (new =
& 0xffff) << shift;

Same here.

> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  460  		mask =3D ~(0xf=
fff << shift);
> 4148575abe1e14 Heiko Carstens           2022-11-02  461  		asm volatile(
> 4148575abe1e14 Heiko Carstens           2022-11-02  462  			"	spka	0(%[ke=
y])\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  463  			"	sacf	256\n"
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  464  			"	llill	%[cou=
nt],%[max_loops]\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  465  			"0:	l	%[prev]=
,%[address]\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  466  			"1:	nr	%[prev=
],%[mask]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  467  			"	xilf	%[mask=
],0xffffffff\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  468  			"	or	%[new],%=
[prev]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  469  			"	or	%[prev],=
%[tmp]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  470  			"2:	lr	%[tmp]=
,%[prev]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  471  			"3:	cs	%[prev=
],%[new],%[address]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  472  			"4:	jnl	5f\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  473  			"	xr	%[tmp],%=
[prev]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  474  			"	xr	%[new],%=
[tmp]\n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  475  			"	nr	%[tmp],%=
[mask]\n"
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  476  			"	jnz	5f\n"
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  477  			"	brct	%[coun=
t],2b\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  478  			"5:	sacf	768\=
n"
> 4148575abe1e14 Heiko Carstens           2022-11-02  479  			"	spka	%[defa=
ult_key]\n"
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  480  			EX_TABLE_UA_L=
OAD_REG(0b, 5b, %[rc], %[prev])
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  481  			EX_TABLE_UA_L=
OAD_REG(1b, 5b, %[rc], %[prev])
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  482  			EX_TABLE_UA_L=
OAD_REG(3b, 5b, %[rc], %[prev])
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  483  			EX_TABLE_UA_L=
OAD_REG(4b, 5b, %[rc], %[prev])
> 4148575abe1e14 Heiko Carstens           2022-11-02  484  			: [rc] "+&d" =
(rc),
> 4148575abe1e14 Heiko Carstens           2022-11-02  485  			  [prev] "=3D=
&d" (prev),
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  486  			  [address] "=
+Q" (*(int *)address),
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  487  			  [tmp] "+&d"=
 (_old),
> 51098f0eb22e2f Janis Schoetterl-Glausch 2022-11-16  488  			  [new] "+&d"=
 (_new),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  489  			  [mask] "+&d=
" (mask),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  490  			  [count] "=
=3Da" (count)
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  491  			: [key] "%[co=
unt]" (key << 4),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  492  			  [default_ke=
y] "J" (PAGE_DEFAULT_KEY),
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  493  			  [max_loops]=
 "J" (CMPXCHG_USER_KEY_MAX_LOOPS)
> 4148575abe1e14 Heiko Carstens           2022-11-02  494  			: "memory", "=
cc");
> 4148575abe1e14 Heiko Carstens           2022-11-02  495  		*(unsigned sho=
rt *)uval =3D prev >> shift;
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  496  		if (!count)
> 739ad2e4e15b58 Janis Schoetterl-Glausch 2022-11-17  497  			rc =3D -EAGAI=
N;
> 4148575abe1e14 Heiko Carstens           2022-11-02  498  		return rc;

[...]
