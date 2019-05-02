Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB62A12209
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2019 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEBSmD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 14:42:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbfEBSmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 14:42:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42IMAPF132869;
        Thu, 2 May 2019 14:41:18 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s845hmgnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 May 2019 14:41:18 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x42CejLI015969;
        Thu, 2 May 2019 12:45:15 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2s4eq3wd6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 May 2019 12:45:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42IfGka42926352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 18:41:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6FEB2064;
        Thu,  2 May 2019 18:41:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60575B205F;
        Thu,  2 May 2019 18:41:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 18:41:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E7F8016C33C8; Thu,  2 May 2019 11:41:16 -0700 (PDT)
Date:   Thu, 2 May 2019 11:41:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] rcutorture: Tweak kvm options
Message-ID: <20190502184116.GA8811@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190424073446.8577-1-bigeasy@linutronix.de>
 <20190424103809.GM3923@linux.ibm.com>
 <20190424183039.GA4494@linux.ibm.com>
 <20190425194638.GA7238@linux.ibm.com>
 <20190426105413.rajcon4vyzov446c@linutronix.de>
 <20190426135058.GD3923@linux.ibm.com>
 <20190429081943.gucbalncrrttxxcr@linutronix.de>
 <20190429144924.GP3923@linux.ibm.com>
 <20190429150600.GA14389@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190429150600.GA14389@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020118
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 29, 2019 at 08:06:00AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 29, 2019 at 07:49:24AM -0700, Paul E. McKenney wrote:
> > On Mon, Apr 29, 2019 at 10:19:44AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-04-26 06:50:58 [-0700], Paul E. McKenney wrote:
> > > > One place to look is in the summary output:
> > > > 
> > > > TREE01 ------- 17540 GPs (58.4667/s) [rcu: g130629 f0x0 ]
> > > > 
> > > > The "58.4667/s" is the number of grace periods per second.  I would be
> > > > surprised if CONFIG_PARAVIRT_SPINLOCKS made a noticeable difference in
> > > > grace-period rate (given the natural variation), but you never know.
> > > 
> > > I did four runs of the different parts of the patch:
> > > - 5.1-rc6
> > > - #1 + kvm64 CPU + some config options
> > > - #2 + tsc-deadline=on and so on (the whole line)
> > > - #3 + CONFIG_PARAVIRT_SPINLOCKS (now everything)
> > > 
> > > the test command was
> > > 	tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 112 --duration 60 --configs "16*TREE08" --memory 4G
> > > 
> > > and the results:
> > > | HEAD is now at 085b7755808a... Linux 5.1-rc6
> > > | (28.5942 +27.4658 +28.0203 +27.2061 +28.0731 +26.9078 +27.8494 + 27.3392 +26.4339 +28.025 +27.4797 +27.6775 +28.0653 +28.0742 +27.9581 +28.6508)/ 16
> > > | 27.738775
> > > | 
> > > | HEAD is now at 36a12aa9761a... tune #1
> > > | (28.5761 +26.6514 +26.6989 +27.4375 +27.3442 +28.3228 +26.6353 +27.5461+28.5531 +27.7006 +27.8078 +27.9753 +27.4269 +28.0464 +27.6314 +27.8356) / 16
> > > | 27.6368375
> > > | 
> > > | HEAD is now at af5cd7196436... tune #2
> > > | (28.4867 +26.3675 +27.6364 +28.3344 +27.4153 +27.9306 +27.1703 +26.8461+27.3194 +28.5486 +27.8975 +27.4356 +28.12 +28.4397 +29.0186 +26.9328 )/ 16
> > > | 27.74371875
> > > | 
> > > | HEAD is now at 3701f64943f5... tune #3
> > > | (28.2431 +27.7831 +28.39 +28.2586 +27.7408 +27.9258 +26.6236 +26.7817+29.1178 +26.9564 +29.0525 +27.4258 +27.4931 +27.8928 +26.9308 +28.4833)/ 16
> > > | 27.8187
> > > 
> > > This 28.… is the number of GP/s. Based on the results in looks like
> > > noise to me. Also I have no idea why you have more than twice as many
> > > GP/s as I do.
> > 
> > My guess is that because you have more CPUs, the for_each_online_cpu()
> > loop takes longer on your system.
> 
> OK, that is rather oversimplified, to say the least.  A better way to
> put this is that the probability of some CPU holding things up is larger
> the more CPUs you have.  RCU doe take explicit steps to slow down grace
> periods, but that doesn't start kicking in until 256 CPUs.

And I ended up with the following variant of your patch.  If I don't
hear otherwise from you, I will assume that you are OK with it.  So if
something bothers you about it, please don't suffer in silence!

							Thanx, Paul

------------------------------------------------------------------------

commit 4a04229cf73ac9bc1ae15357beb32a0b37be1480
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed Apr 24 09:34:46 2019 +0200

    rcutorture: Tweak kvm options
    
    In one of my rcutorture tests the TSC clocksource got marked unstable
    due to a large difference in the TSC value. I'm not sure if the guest
    run for a long time with disabled interrupts or if the host was very
    busy and didn't schedule the guest for some time.
    
    I took a look on the qemu/KVM options and decided to update the options:
    
    - Use kvm{32|64} as CPU. We could probably use `host' (like ARM does)
      for maximum available features but since we don't run any userland I'm
      not sure if it makes any difference.
    
    - Drop the "noapic" option. There is no history why the APIC was disabled,
      I see no reason for it.  Once old qemu versions fade away, we can add
      "x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on".
    
    - Additional config options. It ensures that the kernel knowns that it
      runs as a kvm guest and can use virt devices like the kvm-clock as
      clocksource. The kvm-clock was the main motivation here.
    
    - I didn't add a random HW device. It would make the random device ready
      earlier (not it doesn't complete the initialisation at all) but I
      doubt that there is any need for this.
    
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    [ paulmck: The world is not quite ready for CONFIG_PARAVIRT_SPINLOCKS=y
      and x2apic, so they are omitted for the time being. ]
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 6bcb8b5b2ff2..c3a49fb4d6f6 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -172,7 +172,7 @@ identify_qemu_append () {
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
-		echo noapic selinux=0 initcall_debug debug
+		echo selinux=0 initcall_debug debug
 		;;
 	qemu-system-aarch64)
 		console=ttyAMA0
@@ -191,8 +191,19 @@ identify_qemu_append () {
 # Output arguments for qemu arguments based on the TORTURE_QEMU_MAC
 # and TORTURE_QEMU_INTERACTIVE environment variables.
 identify_qemu_args () {
+	local KVM_CPU=""
+	case "$1" in
+	qemu-system-x86_64)
+		KVM_CPU=kvm64
+		;;
+	qemu-system-i386)
+		KVM_CPU=kvm32
+		;;
+	esac
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
+		echo -machine q35,accel=kvm
+		echo -cpu ${KVM_CPU}
 		;;
 	qemu-system-aarch64)
 		echo -machine virt,gic-version=host -cpu host
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
index d2d2a86139db..e19a444a0684 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,2 +1,5 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_KVM_GUEST=y
